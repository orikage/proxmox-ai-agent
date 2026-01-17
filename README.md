# proxmox-ai-agent

AI agents (ClaudeCode/Gemini CLI) for Proxmox VE management via REST API.

## Setup

1. Clone this repository
```bash
git clone https://github.com/YOUR_USERNAME/proxmox-ai-agent.git
cd proxmox-ai-agent
```

2. Configure environment
```bash
cp .env.example .env
# Edit .env with your Proxmox API token and AI API keys
```

3. Create Proxmox API Token
   - Datacenter → Permissions → API Tokens → Add
   - User: `agent@pam` (create user first if needed)
   - Token ID: `claude-agent`
   - Privilege Separation: Check (recommended) or Uncheck

4. Start the agent
```bash
docker compose up -d
docker compose exec ai-agent bash
```

5. Run ClaudeCode
```bash
claude
```

## Available Scripts

- `pve-api` - Raw API wrapper
- `pve-nodes` - List nodes
- `pve-vms` - List VMs
- `pve-lxc` - List LXC containers
- `pve-status` - Node status

## Security Notes

- Store API tokens securely
- Use minimal permissions for the API token
- Never commit `.env` file
