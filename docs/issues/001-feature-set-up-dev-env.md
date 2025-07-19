# 001-feature-set-up-dev-env

## 概要
ローカル開発環境を構築し、バックエンド（Rails API）とフロントエンド（Nuxt.js）を起動して、画面が表示されるところまでの手順を記述する。

## 必要なツール
- Node.js (v20以上) ※Nuxt 4.0対応
- Ruby (v3.2.2)
- PostgreSQL (v14以上)
- Docker & Docker Compose

## 手順

### 1. リポジトリのクローン
```bash
git clone https://github.com/tomooshima0828/portfolio-nuxt-rails-dashboard.git
cd portfolio-nuxt-rails-dashboard
```

### 2. バックエンド環境構築

#### 2.1 依存関係のインストール
```bash
cd backend
bundle install
```

#### 2.2 データベース設定
```bash
# PostgreSQLサーバーを起動（Dockerの場合）
docker run --name postgres-dashboard -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:14

# データベース作成とマイグレーション
rails db:create
rails db:migrate
rails db:seed
```

#### 2.3 Rails APIサーバー起動
```bash
rails server
```

### 3. フロントエンド環境構築

#### 3.1 Nuxt.jsプロジェクト作成
```bash
cd ../frontend
npx nuxi@latest init .
npm install
```

#### 3.2 必要なパッケージのインストール
```bash
# TypeScript関連
npm install --save-dev typescript @nuxt/typescript-build

# Tailwind CSS
npm install --save-dev @nuxtjs/tailwindcss

# Chart.js関連
npm install chart.js vue-chartjs

# Axios（API通信用）
npm install @nuxtjs/axios
```

#### 3.3 Nuxt.js設定
`nuxt.config.ts`を編集：
```typescript
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/axios'
  ],
  axios: {
    baseURL: 'http://localhost:3000/api/v1'
  },
  css: ['~/assets/css/main.css']
})
```

#### 3.4 フロントエンドサーバー起動
```bash
npm run dev -- --port 8080
```

### 4. Docker環境構築（オプション）

#### 4.1 docker-compose.yml作成
プロジェクトルートに`docker-compose.yml`を作成：
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:14
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_DB: portfolio_nuxt_rails_dashboard_development
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    depends_on:
      - postgres
    environment:
      DATABASE_URL: postgresql://postgres:password@postgres:5432/portfolio_nuxt_rails_dashboard_development
    ports:
      - "3000:3000"
    volumes:
      - ./backend:/app
    command: bundle exec rails server -b 0.0.0.0 -p 3000

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    depends_on:
      - backend
    ports:
      - "8080:8080"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - NUXT_HOST=0.0.0.0
      - NUXT_PORT=8080
    command: npm run dev -- --port 8080

volumes:
  postgres_data:
```

#### 4.2 フロントエンド用Dockerfile作成
`frontend/Dockerfile`を作成：
```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

EXPOSE 8080

CMD ["npm", "run", "dev", "--", "--port", "8080"]
```

#### 4.3 バックエンド用Dockerfile修正
`backend/Dockerfile`を修正（必要に応じて）：
```dockerfile
FROM ruby:3.2.2-alpine

WORKDIR /app

# 依存関係インストール
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    tzdata

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
```

#### 4.4 Docker環境起動
```bash
# Docker環境起動
docker-compose up -d

# データベース準備
docker-compose exec backend rails db:create
docker-compose exec backend rails db:migrate
docker-compose exec backend rails db:seed
```

### 5. 動作確認

#### 5.1 バックエンド動作確認
```bash
# Railsの初期画面確認
curl http://localhost:3000
```

#### 5.2 フロントエンド動作確認
ブラウザで`http://localhost:8080`にアクセスし、Nuxt.jsの初期画面が表示されることを確認。

#### 5.3 Docker環境での動作確認
```bash
# Docker環境でのバックエンド確認
curl http://localhost:3000

# Docker環境でのフロントエンド確認
# ブラウザで http://localhost:8080 にアクセス
```

### 6. 開発時の注意点

#### 6.1 CORS設定
- バックエンドのCORS設定で`localhost:8080`を許可済み
- フロントエンドのベースURLは`http://localhost:3000/api/v1`

#### 6.2 データベース接続
- PostgreSQL接続情報は`config/database.yml`で管理
- 開発環境では`username: postgres`, `password: password`を使用

#### 6.3 ポート番号
- フロントエンド（Nuxt.js）: `8080`
- バックエンド（Rails API）: `3000`
- PostgreSQL: `5432`

## 完了条件
- [ ] バックエンド（Rails）が正常に起動し、初期画面が表示される
- [ ] フロントエンド（Nuxt.js）が正常に起動し、ブラウザで初期画面が表示される
- [ ] PostgreSQLデータベースが正常に動作する
- [ ] Docker環境で両方のサービスが正常に起動し、初期画面が表示される

## 次のステップ
- APIコントローラーの実装
- フロントエンドでのChart.jsセットアップ
- ダッシュボード画面の作成