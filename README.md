# Chromebook System Maintenance & Automation Script

This project provides a secure and customizable Bash-based automation script for maintaining and enhancing Chromebook Linux (Crostini) environments. It simplifies system updates, installs essential developer tools, manages system resources (like swap), and enforces basic security configurations.

> **Author:** Vincent Wachira  
> **License:** MIT  
> **Status:** Stable  

---

## 🚀 Features

- Full `apt` package update and upgrade automation
- Install essential development tools and system utilities
- Automatically configure swap space for improved performance
- Harden system with basic security measures (ufw, fail2ban, unattended upgrades)
- Optional automation via `cron` or `systemd` for periodic execution
- Centralized configuration using `.env` file

---

## 🛠️ Prerequisites

- Chromebook with Linux (Crostini) enabled
- Bash 5+
- Git
- `sudo` privileges

---

## 📂 File Structure

```bash
.
├── setup.sh               # Main executable automation script
├── .env                   # Configuration file with system parameters
├── README.md              # Project documentation
├── LICENSE                # Open-source license (MIT)
└── logs/                  # Directory for execution logs

```

## ⚙️ Setup Instructions

**1. Clone the Repo**

```bash
git clone https://github.com/VinceBiggz/chromeos-optimizer
cd chromeos-optimizer
```

**2. Make Script Executable**

```bash
chmod +x setup.sh
```

**3. Configure Environment**

Edit the .env file to match your desired setup.

```bash
nano .env
```

**4. Run the Script**

```bash
./setup.sh
```
You will be prompted for sudo where necessary.

## 🔁 Automating Execution

**Option 1: Cron Job (Weekly)**

```bash
crontab -e
```
Add the following line (adjust path accordingly):

```bash
@weekly /home/username/path/to/chromeos-optimizer/setup.sh >> /home/username/path/to/chromeos-optmizer/logs/weekly_run.log 2>&1
```

**Option 2: Systemd Timer (Advanced)**
Recommended for more robust scheduling and logging. See docs/systemd-automation.md for setup.

## 📦 Tools Installed

- git, curl, wget, vim, htop
- ufw, fail2ban, unattended-upgrades
- build-essential, software-properties-common

## 🧪 Testing
- Run the script in a test VM or sandboxed environment to validate configurations. Logs are stored in logs/.

## 🙋‍♂️ Troubleshooting
- Ensure .env is properly configured.
- Check file permissions.
- Review logs/ for errors or failures.
- Confirm internet connectivity and apt availability.

## 📜 License
- This project is licensed under the MIT License.

## 🤝 Contributing
- Pull requests are welcome. For significant changes, please open an issue first to discuss your proposal.

## 🧠 Credits
- Project by Vincent Wachira
- GitHub: VinceBiggz

---

