# 个人 DNS 基础设施(Terraform)

管理个人域名 `panda.qzz.io` 的 Cloudflare DNS。从公司仓库(`autolife-robotics`)拆出来,**公司和个人的 URL 分开管理**。

## 运行方式:HCP Terraform 自动 apply

- Backend:HCP Terraform(Terraform Cloud),个人 organization
- Workspace:`personal-dns`(见 `main.tf`)
- 触发:push 到 `main` 即自动 plan / apply

> ⚠️ `main.tf` 里的 `organization` 目前是占位符 `REPLACE_WITH_YOUR_ORG_SLUG`,**必须改成你的 org slug**(就是 `app.terraform.io/app/<org>/workspaces` 里的 `<org>`,不是 HCP 门户 URL 里的 UUID)。

## 文件结构

```
terraform/
├── main.tf         # terraform 设置、Cloudflare provider、HCP backend
├── variables.tf    # 变量(API token、服务器 IP)
└── cloudflare.tf   # panda.qzz.io 的 zone + 全部 DNS 记录
```

## 初次启用步骤

1. **改 `main.tf`** 的 `organization` 为你的 org slug;workspace 名按需调整。
2. 在 HCP Terraform 该 workspace 里加变量:
   - `cloudflare_api_token`(Category = Terraform variable,✅ Sensitive,❌ 不勾 HCL)。token 需有 **Zone 创建 + DNS 编辑**权限。
3. push 到 `main`,确认 plan(应为**全部 create**:1 个 zone + 14 条记录)后 apply。
4. apply 后,Cloudflare 会给这个新 zone 分配一对 **nameserver**。到 `qzz.io` 的注册商把 NS 改成 Cloudflare 给的那两个,解析才会生效(有一段传播时间)。

> 背景:原来的 panda.qzz.io zone 已在公司仓库里被销毁,所以这里是**重新创建**,会拿到新的 NS,需要在注册商处重新委派。

## 管理的记录

| 记录 | 类型 | 指向 | 代理 |
|---|---|---|---|
| `casibase` | A | gz-office | ✅ |
| `wgmesh` | A | oracle-amd-002 | ✅ |
| `hashtopolis` | A | oracle-arm-002 | ✅ |
| `api` | A | oracle-arm-002 | ✅ |
| `auth` | A | oracle-arm-002 | ✅ |
| `db` | A | oracle-arm-002 | ❌(直连 PostgreSQL 5432) |
| `realtime` | A | oracle-arm-002 | ✅(Supabase Realtime WS) |
| `*.realtime` | A | oracle-arm-002 | ❌(按租户子域路由) |
| `sub2api` | A | oracle-amd-002 | ✅ |
| `resend._domainkey` / `send` / `_dmarc` / `@` | TXT/MX | Resend 邮件(SES) | — |

## 新增一条记录

在 `cloudflare.tf` 加:

```hcl
resource "cloudflare_dns_record" "example" {
  zone_id = cloudflare_zone.panda_qzz_io.id
  name    = "example"   # 子域前缀;"@" 表示主域
  content = var.oracle_arm_002_ip
  type    = "A"
  ttl     = 1           # 1 = Auto
  proxied = false

  lifecycle {
    create_before_destroy = true
  }
}
```

## 本地开发(可选)

```bash
cd terraform
terraform init
terraform plan
```

## 安全提示

- 凭证只放 HCP Terraform 的 sensitive 变量,别写进仓库。
- token 一旦暴露请到 Cloudflare 控制台轮换后再更新。
