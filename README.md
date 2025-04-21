# Nginx OpenResty NTLM Docker 解決方案

這是一個基於 Nginx OpenResty 的 Docker 容器解決方案，整合了 NTLM 認證模組，用於快速部署和配置 NTLM 認證的代理服務器。
如果你有代理PowerBI和Security等需求，可開箱即用此映像檔建構代理服務。

## 功能特點

- 基於 Nginx OpenResty 的高性能 Web 服務器
- 內建 NTLM 認證模組
- Docker 容器化部署
- 可配置的 NTLM 認證參數
- 支持反向代理和負載均衡

## 系統要求

- Docker 20.10.0 或更高版本
- Docker Compose 1.29.0 或更高版本（可選）

## 快速開始

1. 克隆此倉庫：
```bash
git clone [repository-url]
cd nginx-openresty-ntlm
```

2. 配置 NTLM 認證參數：
```bash
cp .env.example .env
# 編輯 .env 文件設置您的 NTLM 認證參數
```

3. 啟動服務：
```bash
docker-compose up -d
```

## 配置說明

### 環境變量

在 `.env` 文件中可以配置以下參數：

- `NTLM_DOMAIN`: NTLM 域名
- `NTLM_USERNAME`: NTLM 用戶名
- `NTLM_PASSWORD`: NTLM 密碼
- `PROXY_PASS`: 代理目標地址

### Nginx 配置

主要的 Nginx 配置文件位於 `conf/nginx.conf`，您可以根據需要修改：

- 代理規則
- SSL 配置
- 日誌設置
- 性能調優參數

## 使用範例

### 基本代理配置

```nginx
location / {
    proxy_pass http://backend;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}
```

## 維護和更新

### 更新容器

```bash
docker-compose pull
docker-compose up -d
```

### 查看日誌

```bash
docker-compose logs -f
```

## 故障排除

常見問題和解決方案：

1. NTLM 認證失敗
   - 檢查域名、用戶名和密碼是否正確
   - 確認網絡連接是否正常

2. 代理連接問題
   - 檢查目標服務器是否可達
   - 確認防火牆設置

## 安全建議

- 定期更新容器鏡像
- 使用強密碼
- 限制訪問 IP
- 啟用 SSL/TLS 加密

## 貢獻指南

歡迎提交 Pull Request 或報告問題。請確保：

1. 遵循現有的代碼風格
2. 添加適當的測試
3. 更新相關文檔

## 授權

[授權類型] - 查看 LICENSE 文件獲取詳細信息

## 聯繫方式

如有問題或建議，請通過以下方式聯繫：

- 提交 Issue
- 發送郵件至 [zero102x@gmail.com]