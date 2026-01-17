# proxmox-ai-agent

AI agents (ClaudeCode/Gemini CLI) for Proxmox VE management via REST API.

## このリポジトリでできること

このリポジトリは、Claude CodeやGemini CLIなどのAIエージェントが、Proxmox VE (PVE) 環境を操作・管理するための実行環境を提供します。

主な機能:
- **Proxmox VEの操作**: 付属のスクリプトやAPIラッパーを通じて、PVE上のリソース（ノード、VM、LXCコンテナ）の情報取得や管理が可能です。
- **AIエージェント用環境**: Dockerコンテナとして環境がパッケージ化されており、AIエージェントをすぐに起動してPVE操作を行わせることができます。
- **拡張可能なツールセット**: 基本的なスクリプト (`pve-vms`, `pve-status` など) に加え、任意のAPIエンドポイントを叩ける `pve-api` ラッパーが含まれているため、バックアップ作成やVM作成など、複雑なタスクもAIに指示可能です。

## インストールとセットアップ

1. **リポジトリのクローン**
   ```bash
   git clone https://github.com/YOUR_USERNAME/proxmox-ai-agent.git
   cd proxmox-ai-agent
   ```

2. **環境変数の設定**
   `.env.example` をコピーして `.env` ファイルを作成し、ご自身の環境に合わせて編集してください。
   ```bash
   cp .env.example .env
   # .env ファイルを編集して Proxmox APIトークンと AI APIキーを設定
   ```

3. **Proxmox APIトークンの作成**
   Proxmox VEの管理画面で設定します。
   - `Datacenter` → `Permissions` → `API Tokens` → `Add` を選択
   - User: `agent@pam` (必要に応じてユーザーを先に作成してください)
   - Token ID: `claude-agent` (任意の名前)
   - Privilege Separation: チェック推奨（権限分離のため）

4. **エージェントの起動**
   Dockerを使って環境を構築・起動します。
   ```bash
   docker compose up -d
   docker compose exec ai-agent bash
   ```

5. **AIツールの実行**
   コンテナ内のシェルに入ったら、AIツールを起動します。
   ```bash
   claude
   ```

## Setup (English)

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
