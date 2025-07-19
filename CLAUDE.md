# CLAUDE.md

## Project Overview
売上データ可視化ダッシュボードアプリケーション
- フロントエンド: Nuxt.js + TypeScript + Tailwind CSS + Chart.js
- バックエンド: Rails 8 API + PostgreSQL
- 4種類のグラフ表示: 円グラフ、棒グラフ、折れ線グラフ、レーダーチャート

## Project Structure
```
portfolio-nuxt-rails-dashboard/
├── frontend/          # Nuxt.js application
├── backend/           # Rails API application
├── docs/              # Project documentation
└── CLAUDE.md         # This file
```

## Development Commands

### Frontend (Nuxt.js)
```bash
cd frontend
npm install
npm run dev          # Development server
npm run build        # Production build
npm run lint         # ESLint
npm run typecheck    # TypeScript check
```

### Backend (Rails)
```bash
cd backend
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server         # Development server
bundle exec rspec    # Run tests
```

## Key Features
1. **Pie Chart**: 商品カテゴリ別売上比率
2. **Bar Chart**: 月次売上高
3. **Line Chart**: 年間売上トレンド
4. **Radar Chart**: 商品特徴比較

## API Endpoints
- `GET /api/v1/sales_by_category` - カテゴリ別売上データ
- `GET /api/v1/monthly_sales` - 月次売上データ
- `GET /api/v1/sales_trend` - 売上トレンドデータ
- `GET /api/v1/product_comparison` - 商品比較データ

## Database Schema
- `products` - 商品情報
- `orders` - 注文情報
- `order_items` - 注文明細

## Development Notes
- 仕様書駆動開発を採用
- グラフ描画スキル習得が目的
- デモデータを使用して開発