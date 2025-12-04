<p align="center">
  <img src="https://raw.githubusercontent.com/RichardBarron27/red-specter-offensive-framework/main/assets/red-specter-logo.png" alt="Red Specter Logo" width="200">
</p>

<br>

# 🛡️ Red Specter: Port Surge Guardian (v0.1 – Bash MVP)

[![Stars](https://img.shields.io/github/stars/RichardBarron27/redspecter-port-surge-guardian?style=flat&logo=github)](https://github.com/RichardBarron27/redspecter-port-surge-guardian/stargazers)
![Last Commit](https://img.shields.io/github/last-commit/RichardBarron27/redspecter-port-surge-guardian)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Kali-purple)
![License](https://img.shields.io/github/license/RichardBarron27/redspecter-port-surge-guardian)

> **Monitors listening ports and detects sudden exposure or port surges on a host.**  
Part of the **Red Specter | VIGIL** defensive tooling ecosystem.

---

## 🔍 What It Does

Port Surge Guardian continuously tracks **listening TCP/UDP ports** and:

✔ Detects **NEW** listening ports  
✔ Detects **CLOSED** ports  
✔ Alerts on **port surges**  
✔ Logs everything to `/var/log/port-surge-guardian.log`  

Uses `ss` – a **read-only view** of system sockets.

---

## 🧠 Why It Exists

Attackers:
- Drop **bind shells**
- Expose new listeners for **exfil**
- Misconfigure deployments
- Hide malware behind high ports

Most admins **never see** when a port pops open.

Port Surge Guardian acts as a **tripwire**:

> “What just started listening on this machine?”

---

## ⚙️ Quick Start

```bash
git clone https://github.com/RichardBarron27/redspecter-port-surge-guardian.git
cd redspecter-port-surge-guardian
chmod +x port-surge-guardian.sh
sudo ./port-surge-guardian.sh

