# proxmox-ai-agent

AI agents (ClaudeCode/Gemini CLI) for Proxmox VE management via REST API.

## このリポジトリでできること

このリポジトリは、Claude CodeやGemini CLIなどのAIエージェントが、Proxmox VE (PVE) 環境を操作・管理するための実行環境を提供します。

主な機能:
- **Proxmox VEの操作**: 付属のスクリプトやAPIラッパーを通じて、PVE上のリソース（ノード、VM、LXCコンテナ）の情報取得や管理が可能です。
- **AIエージェント用環境**: Dockerコンテナとして環境がパッケージ化されており、AIエージェントをすぐに起動してPVE操作を行わせることができます。
- **拡張可能なツールセット**: 基本的なスクリプト (`pve-vms`, `pve-status` など) に加え、任意のAPIエンドポイントを叩ける `pve-api` ラッパーが含まれているため、バックアップ作成やVM作成など、複雑なタスクもAIに指示可能です。

## Dockege (Proxmox上) へのインストール

Proxmox上に設置されたDockege環境で、このAIエージェントを実行および管理する手順です。

1. **リポジトリの配置 (Stackの作成)**
   Dockegeが管理するスタック用ディレクトリ（例: `/opt/stacks` や `/opt/dockege/stacks` など）に移動し、このリポジトリをクローンします。
   ```bash
   # Dockegeのスタックディレクトリへ移動 (環境に合わせてパスを変更してください)
   cd /opt/stacks
   
   # リポジトリをクローン
   git clone https://github.com/YOUR_USERNAME/proxmox-ai-agent.git
   ```
   これでDockegeのUI上に `proxmox-ai-agent` というスタックが表示されます。

2. **環境変数の設定**
   DockegeのWeb UIにアクセスし、`proxmox-ai-agent` スタックを選択して「Edit」をクリックします。
   「Environment Variables (環境変数)」エリアに、`.env.example` を参考に必要な値を入力します。

   ```env
   # Proxmoxの設定
   PROXMOX_HOST=192.168.1.100  # ProxmoxホストのIP
   PROXMOX_PORT=8006
   PROXMOX_TOKEN_ID=agent@pam!claude-agent
   PROXMOX_TOKEN_SECRET=your-token-secret-here

   # AI APIキー
   ANTHROPIC_API_KEY=sk-ant-xxxxx
   GEMINI_API_KEY=xxxxx
   ```
   *ヒント*: `docker-compose.yml` で `network_mode: host` が設定されているため、ホスト側のネットワークに直接アクセス可能です。

3. **ビルドとデプロイ**
   Dockege UI上の「Deploy」ボタンをクリックします。
   初回はDockerイメージのビルドが行われるため、数分かかる場合があります。

4. **AIツールの実行**
   デプロイ完了後、Dockege UIの「Terminal」タブ（または `docker exec`）を使用してコンテナのシェルに入ります。
   ```bash
   # コンテナ内で実行
   claude
   ```
   これで、AIエージェントがProxmox環境の管理や状況確認を行えるようになります。

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
