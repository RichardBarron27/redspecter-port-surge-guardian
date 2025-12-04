<p align="center">
  <img src="https://raw.githubusercontent.com/RichardBarron27/red-specter-offensive-framework/main/assets/red-specter-logo.png" alt="Red Specter Logo" width="200">
</p>

<br>

# 🛡️ Red Specter: Port Surge Guardian (v0.1 – Bash MVP)

<p>
  <a href="https://github.com/RichardBarron27/redspecter-port-surge-guardian/stargazers">
    <img src="https://img.shields.io/github/stars/RichardBarron27/redspecter-port-surge-guardian?style=flat&logo=github" alt="Stars">
  </a>
  <img src="https://img.shields.io/github/last-commit/RichardBarron27/redspecter-port-surge-guardian" alt="Last Commit">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen" alt="PRs Welcome">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Kali-purple" alt="Platform">
  <img src="https://img.shields.io/github/license/RichardBarron27/redspecter-port-surge-guardian" alt="MIT License">
</p>

> **Monitors listening ports and detects sudden exposure or port surges on a host.**  
Part of the **Red Specter | VIGIL** defensive tooling ecosystem.

---

## 🔍 What It Does

Port Surge Guardian continuously tracks **listening TCP/UDP ports** and:

✔ Detects **NEW** listening ports  
✔ Detects **CLOSED** ports  
✔ Alerts on **port surges**  
✔ Logs everything to `/var/log/port-surge-guardian.log`  

Uses `ss` for a **read-only view** of socket state.

---

## ⚙️ Quick Start

```bash
git clone https://github.com/RichardBarron27/redspecter-port-surge-guardian.git
cd redspecter-port-surge-guardian
chmod +x port-surge-guardian.sh
sudo ./port-surge-guardian.sh
🧪 Example Test
python3 -m http.server 8080


Expected alert:

[NEW] Listening ports opened:
  + tcp:8080


Stop server:

[CLOSED] Listening ports closed:
  - tcp:8080


📌 Screenshot coming soon

🛑 Safety & Ethics

Read-only system monitoring

No packet generation

No firewall or network changes

Only use on systems you are authorized to monitor

🚀 Roadmap

Port allow/blocklist (ignore known ports)

JSON logs for SIEM ingestion

Slack / webhook alerting

Dashboard view of port changes

Correlation with DDoS Flood Sentinel for full host defense

❤️ Support Red Specter

If this helps you, support future development:

☕ Buy Me A Coffee
https://www.buymeacoffee.com/redspecter

💼 PayPal
https://paypal.me/richardbarron1747

<p align="center"><strong>Created by Red Specter | VIGIL</strong><br> Ethical Offensive Security — powered by smart defense. </p> ```

END COMPLETE README
