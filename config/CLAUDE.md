# Proxmox AI Agent

Proxmox VE を REST API 経由で管理するエージェント環境です。

## 利用可能なコマンド

### 情報取得（安全）
```bash
pve-nodes          # ノード一覧
pve-vms [node]     # VM一覧
pve-lxc [node]     # LXC一覧
pve-status [node]  # ノードステータス
pve-api GET <endpoint>  # 任意のGETリクエスト
```

### 操作（要確認）
```bash
# VM起動
pve-api POST /nodes/{node}/qemu/{vmid}/status/start

# VM停止
pve-api POST /nodes/{node}/qemu/{vmid}/status/stop

# LXC起動
pve-api POST /nodes/{node}/lxc/{vmid}/status/start
```

## API エンドポイント例

| 操作 | メソッド | エンドポイント |
|------|----------|----------------|
| ノード一覧 | GET | /nodes |
| VM一覧 | GET | /nodes/{node}/qemu |
| VM詳細 | GET | /nodes/{node}/qemu/{vmid}/status/current |
| VM起動 | POST | /nodes/{node}/qemu/{vmid}/status/start |
| VM停止 | POST | /nodes/{node}/qemu/{vmid}/status/stop |
| LXC一覧 | GET | /nodes/{node}/lxc |
| ストレージ | GET | /nodes/{node}/storage |
| タスク一覧 | GET | /nodes/{node}/tasks |

## ルール

1. **破壊的操作（stop, shutdown, destroy, delete）は必ず実行前に確認を求める**
2. 不明な場合はまず情報取得してから判断
3. エラー時は生のAPIレスポンスを表示
4. vmidやnodeが不明な場合は一覧取得して確認
