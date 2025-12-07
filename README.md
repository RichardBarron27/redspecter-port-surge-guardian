<p align="center">
  <img src="https://raw.githubusercontent.com/RichardBarron27/red-specter-offensive-framework/main/assets/red-specter-logo.png" alt="Red Specter Logo" width="200">
</p>

<br>

# 🛡️ Red Specter: Port Surge Guardian (v0.1 – Bash MVP)

<p align="center">
  <img src="https://img.shields.io/badge/version-v0.1-blue" alt="Version v0.1">
  <img src="https://img.shields.io/badge/type-defensive%20tool-blueviolet" alt="Defensive Tool">
  <img src="https://img.shields.io/badge/platform-Linux%20%7C%20Kali-purple" alt="Platform Linux/Kali">
  <img src="https://img.shields.io/badge/language-Bash-lightgrey" alt="Language Bash">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen" alt="PRs Welcome">
</p>

> **Monitors listening ports and detects sudden exposure or port surges on a host.**  
Part of the **Red Specter | VIGIL** defensive tooling ecosystem.

---

## 🔍 What It Does

Port Surge Guardian continuously tracks **listening TCP/UDP ports** and:

- Detects **NEW** listening ports  
- Detects **CLOSED** ports  
- Alerts on **sudden increases** in the number of listening ports (surges)  
- Logs everything to: `/var/log/port-surge-guardian.log`  

It uses `ss` for a **read-only view** of socket state.  
It does **not** send any packets or change firewall rules.

---

## ⚙️ Quick Start

```bash
git clone https://github.com/RichardBarron27/redspecter-port-surge-guardian.git
cd redspecter-port-surge-guardian
chmod +x port-surge-guardian.sh
sudo ./port-surge-guardian.sh

Options

| Flag                       | Meaning                      | Default                            |
| -------------------------- | ---------------------------- | ---------------------------------- |
| `-i` / `--interval`        | Seconds between checks       | `5`                                |
| `-s` / `--surge-threshold` | Extra ports to trigger SURGE | `10`                               |
| `-l` / `--log-file`        | Log file path                | `/var/log/port-surge-guardian.log` |

🧪 Example Test

In one terminal:

sudo ./port-surge-guardian.sh


In a second terminal, start a simple HTTP server:

python3 -m http.server 8080


You should see something like:

[NEW] Listening ports opened:
  + tcp:8080


Then stop the server with Ctrl + C and after a few seconds:

[CLOSED] Listening ports closed:
  - tcp:8080

🛑 Safety & Ethics

Defensive-only

No packet generation

No firewall or network modifications

Only run on systems and networks you are authorized to monitor

Red Specter values:
Ethical Intelligence. Precision. Integrity.

🚀 Roadmap

Allowlist for known-good ports/services

JSON log output for SIEM ingestion

Slack / webhook alert integrations

TUI / dashboard for port-change visualization

Correlation with DDoS Flood Sentinel for combined host defense

❤️ Support Red Specter

If this tool (and the wider Red Specter suite) helps you, you can support future development:

☕ Buy Me A Coffee
https://www.buymeacoffee.com/redspecter

💼 PayPal
https://paypal.me/richardbarron1747

Thank you — your support helps build more defensive and ethical security tools. 🛡️⚡

Notice for Users: If you cloned this and found it useful, please consider starring the repo! Stars help with visibility and let me know which projects to maintain.
