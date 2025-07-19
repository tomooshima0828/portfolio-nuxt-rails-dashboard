# 001-feature-set-up-dev-env / 開発環境のセットアップ

## Overview / 概要
This document aims to set up a local development environment, launch both the backend (Rails API) and frontend (Nuxt.js), and verify that the initial screens display correctly. The procedures for achieving this are described below.
この文書は、ローカル開発環境を構築し、バックエンド（Rails API）とフロントエンド（Nuxt.js）を起動して、初期画面が表示されるところまでを目的とする。そのための手順を以下に記述する。

## Prerequisites / 必要なツール
- Node.js (v20 or higher) *For Nuxt 4.0 support
- Ruby (v3.2.2)
- PostgreSQL (v14 or higher)
- Docker & Docker Compose

- Node.js (v20以上) ※Nuxt 4.0対応
- Ruby (v3.2.2)
- PostgreSQL (v14以上)
- Docker & Docker Compose

## Steps / 手順

### 1. Clone Repository / 1. リポジトリのクローン
```bash
git clone https://github.com/tomooshima0828/portfolio-nuxt-rails-dashboard.git
cd portfolio-nuxt-rails-dashboard
```

### 2. Backend Setup / 2. バックエンド環境構築

#### 2.1 Install Dependencies / 2.1 依存関係のインストール
```bash
cd backend
bundle install
```

#### 2.2 Database Configuration / 2.2 データベース設定
```bash
# Start PostgreSQL server (for Docker)
# PostgreSQLサーバーを起動（Dockerの場合）
docker run --name postgres-dashboard -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:14

# Create database and migrate
# データベース作成とマイグレーション
rails db:create
rails db:migrate
rails db:seed
```

#### 2.3 Start Rails API Server / 2.3 Rails APIサーバー起動
```bash
rails server
```

### 3. Frontend Setup / 3. フロントエンド環境構築

#### 3.1 Create Nuxt.js Project / 3.1 Nuxt.jsプロジェクト作成
```bash
cd ../frontend
npx nuxi@latest init .
npm install
```

#### 3.2 Install Required Packages / 3.2 必要なパッケージのインストール
```bash
# TypeScript related
# TypeScript関連
npm install --save-dev typescript @nuxt/typescript-build

# Tailwind CSS
npm install --save-dev @nuxtjs/tailwindcss

# Chart.js related
# Chart.js関連
npm install chart.js vue-chartjs

# Axios (for API communication)
# Axios（API通信用）
npm install @nuxtjs/axios
```

#### 3.3 Nuxt.js Configuration / 3.3 Nuxt.js設定
Edit `nuxt.config.ts`:
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

#### 3.4 Start Frontend Server / 3.4 フロントエンドサーバー起動
```bash
npm run dev -- --port 8080
```

### 4. Docker Environment Setup (Optional) / 4. Docker環境構築（オプション）

#### 4.1 Create docker-compose.yml / 4.1 docker-compose.yml作成
Create `docker-compose.yml` in the project root:
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

#### 4.2 Create Dockerfile for Frontend / 4.2 フロントエンド用Dockerfile作成
Create `frontend/Dockerfile`:
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

#### 4.3 Modify Dockerfile for Backend / 4.3 バックエンド用Dockerfile修正
Modify `backend/Dockerfile` (if necessary):
`backend/Dockerfile`を修正（必要に応じて）：
```dockerfile
FROM ruby:3.2.2-alpine

WORKDIR /app

# Install dependencies
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

#### 4.4 Start Docker Environment / 4.4 Docker環境起動
```bash
# Start Docker environment
# Docker環境起動
docker-compose up -d

# Check container status
# コンテナ状態確認
docker-compose ps

# View logs
# ログ確認
docker-compose logs backend
docker-compose logs frontend

# Prepare database (if needed)
# データベース準備（必要に応じて）
docker-compose exec backend rails db:create
docker-compose exec backend rails db:migrate
docker-compose exec backend rails db:seed

# Stop Docker environment
# Docker環境停止
docker-compose down
```

### 5. Operation Check / 5. 動作確認

#### 5.1 Backend Operation Check / 5.1 バックエンド動作確認
```bash
# Check Rails initial screen
# Railsの初期画面確認
curl http://localhost:3000
```

#### 5.2 Frontend Operation Check / 5.2 フロントエンド動作確認
Access `http://localhost:8080` in your browser and confirm that the Nuxt.js initial screen is displayed.
ブラウザで`http://localhost:8080`にアクセスし、Nuxt.jsの初期画面が表示されることを確認。

#### 5.3 Operation Check in Docker Environment / 5.3 Docker環境での動作確認
```bash
# Check backend in Docker environment
# Docker環境でのバックエンド確認
curl http://localhost:3000

# Check frontend in Docker environment
# Docker環境でのフロントエンド確認
# Access http://localhost:8080 in your browser
# ブラウザで http://localhost:8080 にアクセス
```

### 6. Development Notes / 6. 開発時の注意点

#### 6.1 CORS Configuration / 6.1 CORS設定
- Allow `localhost:8080` in backend CORS settings.
- Frontend base URL is `http://localhost:3000/api/v1`.
- バックエンドのCORS設定で`localhost:8080`を許可済み
- フロントエンドのベースURLは`http://localhost:3000/api/v1`

#### 6.2 Database Connection / 6.2 データベース接続
- PostgreSQL connection information is managed in `config/database.yml`.
- Use `username: postgres`, `password: password` in the development environment.
- PostgreSQL接続情報は`config/database.yml`で管理
- 開発環境では`username: postgres`, `password: password`を使用

#### 6.3 Port Numbers / 6.3 ポート番号
- Frontend (Nuxt.js): `8080` (http://localhost:8080)
- Backend (Rails API): `3000` (http://localhost:3000)
- PostgreSQL: `5432`

#### 6.4 Docker Service URLs / 6.4 Dockerサービス URL
When using Docker environment:
Docker環境使用時：
- Frontend: http://localhost:8080
- Backend API: http://localhost:3000/api/v1
- Database: localhost:5432

## Definition of Done / 完了条件
- [ ] Backend (Rails) starts successfully and the initial screen is displayed.
      バックエンド（Rails）が正常に起動し、初期画面が表示される
- [ ] Frontend (Nuxt.js) starts successfully and the initial screen is displayed in the browser.
      フロントエンド（Nuxt.js）が正常に起動し、ブラウザで初期画面が表示される
- [ ] PostgreSQL database works correctly.
      PostgreSQLデータベースが正常に動作する
- [ ] Both services start successfully in the Docker environment and the initial screen is displayed.
      Docker環境で両方のサービスが正常に起動し、初期画面が表示される

## Next Steps / 次のステップ
- Implement API controllers
  APIコントローラーの実装
- Set up Chart.js on the frontend
  フロントエンドでのChart.jsセットアップ
- Create the dashboard screen
  ダッシュボード画面の作成
