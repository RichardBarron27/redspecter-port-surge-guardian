#!/usr/bin/env bash
#
# Red Specter: Port Surge Guardian (v0.1)
# Monitors listening TCP/UDP ports and alerts on new/closed ports and port-count surges.
#
# Defensive-only. Read-only view of socket state via 'ss'.
#

VERSION="0.1"

CHECK_INTERVAL=5              # Seconds between checks
SURGE_THRESHOLD=10            # Extra ports vs previous snapshot to trigger surge alert
LOG_FILE="/var/log/port-surge-guardian.log"

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RESET="\033[0m"

usage() {
  cat <<EOF
Red Specter: Port Surge Guardian v${VERSION}

Monitors listening TCP/UDP ports and logs:
  * New listening ports (NEW)
  * Closed listening ports (CLOSED)
  * Sudden increases in total listening ports (SURGE)

Usage: $0 [options]

Options:
  -i, --interval N        Check interval in seconds (default: ${CHECK_INTERVAL})
  -s, --surge-threshold N Extra ports vs previous snapshot to trigger SURGE alert (default: ${SURGE_THRESHOLD})
  -l, --log-file PATH     Log file path (default: ${LOG_FILE})
  -h, --help              Show this help and exit

Notes:
  * Requires 'ss' command (usually in iproute2 package)
  * Defensive-only (no packets, no firewall changes)
EOF
  exit 0
}

log_msg() {
  local level="$1"; shift
  local msg="$*"
  local ts
  ts="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "[$ts] [$level] $msg" | tee -a "$LOG_FILE"
}

die() {
  log_msg "ERROR" "$*"
  exit 1
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--interval)
      CHECK_INTERVAL="$2"; shift 2;;
    -s|--surge-threshold)
      SURGE_THRESHOLD="$2"; shift 2;;
    -l|--log-file)
      LOG_FILE="$2"; shift 2;;
    -h|--help)
      usage;;
    *)
      echo "Unknown option: $1"
      usage;;
  esac
done

# Check dependencies
command -v ss >/dev/null 2>&1 || die "'ss' not found. Install iproute2."

mkdir -p "$(dirname "$LOG_FILE")" || die "Cannot create log directory: $LOG_FILE"

BASELINE_FILE="$(mktemp /tmp/port_surge_baseline.XXXXXX)"
CURRENT_FILE="$(mktemp /tmp/port_surge_current.XXXXXX)"

cleanup() { rm -f "$BASELINE_FILE" "$CURRENT_FILE"; }
trap cleanup EXIT

get_listening_ports() {
  ss -tuln 2>/dev/null | awk '
    NR>1 {
      proto=$1
      addr=$5
      n=split(addr, a, ":")
      port=a[n]
      if (port ~ /^[0-9]+$/) {
        print proto ":" port
      }
    }
  ' | sort -u
}

log_msg "INFO" "Starting Port Surge Guardian v${VERSION} (interval=${CHECK_INTERVAL}s, surge_threshold=${SURGE_THRESHOLD}, log_file=${LOG_FILE})"

get_listening_ports > "$BASELINE_FILE"
prev_count=$(wc -l < "$BASELINE_FILE")
log_msg "INFO" "Initial listening ports count: ${prev_count}"

while true; do
  sleep "$CHECK_INTERVAL"

  get_listening_ports > "$CURRENT_FILE"
  curr_count=$(wc -l < "$CURRENT_FILE")

  NEW_PORTS=$(comm -13 "$BASELINE_FILE" "$CURRENT_FILE")
  CLOSED_PORTS=$(comm -23 "$BASELINE_FILE" "$CURRENT_FILE")

  if [[ -n "$NEW_PORTS" ]]; then
    printf "${COLOR_YELLOW}[NEW]${COLOR_RESET} Listening ports opened:\n"
    while IFS= read -r line; do
      echo "  + $line"
      log_msg "ALERT" "NEW listening port: ${line}"
    done <<< "$NEW_PORTS"
  fi

  if [[ -n "$CLOSED_PORTS" ]]; then
    printf "${COLOR_YELLOW}[CLOSED]${COLOR_RESET} Listening ports closed:\n"
    while IFS= read -r line; do
      echo "  - $line"
      log_msg "INFO" "CLOSED listening port: ${line}"
    done <<< "$CLOSED_PORTS"
  fi

  diff=$(( curr_count - prev_count ))
  if (( diff >= SURGE_THRESHOLD )); then
    printf "${COLOR_RED}[SURGE]${COLOR_RESET} Listening port count increased by %d (from %d to %d)\n" "$diff" "$prev_count" "$curr_count"
    log_msg "ALERT" "SURGE in listening ports: +${diff} (from ${prev_count} to ${curr_count})"
  else
    printf "${COLOR_GREEN}[OK]${COLOR_RESET} Listening ports: %d (Δ %d, threshold=%d)\r" "$curr_count" "$diff" "$SURGE_THRESHOLD"
  fi

  cp "$CURRENT_FILE" "$BASELINE_FILE"
  prev_count="$curr_count"
done
