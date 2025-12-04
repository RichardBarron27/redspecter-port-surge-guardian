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
