# 002-feature-database-and-api-setup / データベース・API基盤構築

## Overview / 概要
This issue focuses on implementing the database schema and API endpoints as the foundation for the sales dashboard application. This includes creating models, migrations, seed data, and basic API controllers according to the specifications.
この課題は、売上ダッシュボードアプリケーションの基盤として、データベーススキーマとAPIエンドポイントの実装に焦点を当てます。仕様書に従って、モデル、マイグレーション、シードデータ、基本的なAPIコントローラーを作成します。

## Prerequisites / 前提条件
- [x] 001-feature-set-up-dev-env completed / 001-feature-set-up-dev-env が完了済み
- [x] Docker environment is working / Docker環境が動作している
- [x] Rails API backend is accessible / Rails APIバックエンドにアクセス可能

## Scope / スコープ

### 1. Database Schema Implementation / 1. データベーススキーマ実装

#### 1.1 Create Models and Migrations / 1.1 モデルとマイグレーションの作成
- [ ] Create `Product` model with attributes:
      `Product`モデルを以下の属性で作成：
  - `name` (string, not null) - 商品名
  - `category` (string, not null) - カテゴリ
  - `price` (integer, not null) - 価格
  - `popularity` (integer) - 人気度スコア
  - `rating` (float) - 評価

- [ ] Create `Order` model with attributes:
      `Order`モデルを以下の属性で作成：
  - `order_date` (datetime, not null) - 注文日時
  - `total_amount` (integer, not null) - 合計金額

- [ ] Create `OrderItem` model with attributes:
      `OrderItem`モデルを以下の属性で作成：
  - `order_id` (references orders, not null) - 注文ID
  - `product_id` (references products, not null) - 商品ID
  - `quantity` (integer, not null) - 数量
  - `unit_price` (integer, not null) - 購入時単価

#### 1.2 Model Associations / 1.2 モデル関連付け
- [ ] Set up associations:
      関連付けを設定：
  - `Order` has_many `order_items`
  - `Order` has_many `products` through `order_items`
  - `Product` has_many `order_items`
  - `Product` has_many `orders` through `order_items`
  - `OrderItem` belongs_to `order`
  - `OrderItem` belongs_to `product`

#### 1.3 Database Validations / 1.3 データベースバリデーション
- [ ] Add validations to models:
      モデルにバリデーションを追加：
  - Product: presence of name, category, price
  - Order: presence of order_date, total_amount
  - OrderItem: presence of quantity, unit_price, order_id, product_id

### 2. Seed Data Creation / 2. シードデータ作成

#### 2.1 Demo Data Setup / 2.1 デモデータセットアップ
- [ ] Create realistic product data with categories:
      カテゴリを含む現実的な商品データを作成：
  - Electronics (10 products) - 電子機器
  - Books (8 products) - 書籍
  - Clothing (12 products) - 衣類
  - Home Goods (6 products) - 家庭用品

- [ ] Generate order data spanning 12 months:
      12ヶ月にわたる注文データを生成：
  - Realistic seasonal trends - 現実的な季節トレンド
  - Various order sizes - 様々な注文サイズ
  - Multiple items per order - 注文毎の複数アイテム

- [ ] Ensure data supports all required graphs:
      全ての必要なグラフをサポートするデータを保証：
  - Category-based sales distribution - カテゴリ別売上分布
  - Monthly sales progression - 月次売上推移
  - Daily sales trends - 日次売上トレンド
  - Product comparison metrics - 商品比較指標

### 3. API Endpoints Implementation / 3. APIエンドポイント実装

#### 3.1 Controller Setup / 3.1 コントローラーセットアップ
- [ ] Create `Api::V1::BaseController` with common functionality:
      共通機能を持つ`Api::V1::BaseController`を作成
- [ ] Set up proper CORS configuration for frontend access
      フロントエンドアクセス用のCORS設定を適切に設定

#### 3.2 Sales Analytics Controllers / 3.2 売上分析コントローラー
- [ ] Implement `Api::V1::SalesByCategoryController#index`:
      `Api::V1::SalesByCategoryController#index`を実装：
  - Calculate total sales by product category - 商品カテゴリ別総売上を計算
  - Return JSON response matching API specification - API仕様に合致するJSONレスポンスを返す

- [ ] Implement `Api::V1::MonthlySalesController#index`:
      `Api::V1::MonthlySalesController#index`を実装：
  - Aggregate sales data by month - 月次売上データを集計
  - Support current year data - 今年度データをサポート

- [ ] Implement `Api::V1::SalesTrendController#index`:
      `Api::V1::SalesTrendController#index`を実装：
  - Provide daily sales data for trend analysis - トレンド分析用の日次売上データを提供
  - Support date range filtering - 日付範囲フィルタリングをサポート

- [ ] Implement `Api::V1::ProductComparisonController#index`:
      `Api::V1::ProductComparisonController#index`を実装：
  - Return product metrics for radar chart - レーダーチャート用の商品指標を返す
  - Include price, popularity, rating data - 価格、人気、評価データを含む

#### 3.3 Route Configuration / 3.3 ルート設定
- [ ] Configure API routes in `config/routes.rb`:
      `config/routes.rb`でAPIルートを設定：
```ruby
namespace :api do
  namespace :v1 do
    get 'sales_by_category', to: 'sales_by_category#index'
    get 'monthly_sales', to: 'monthly_sales#index'
    get 'sales_trend', to: 'sales_trend#index'
    get 'product_comparison', to: 'product_comparison#index'
  end
end
```

### 4. Testing and Validation / 4. テストと検証

#### 4.1 Data Validation / 4.1 データ検証
- [ ] Verify all models save correctly with seed data
      シードデータで全モデルが正しく保存されることを確認
- [ ] Test model associations and validations
      モデルの関連付けとバリデーションをテスト
- [ ] Confirm realistic data distribution for visualization
      可視化のための現実的なデータ分布を確認

#### 4.2 API Endpoint Testing / 4.2 APIエンドポイントテスト
- [ ] Test all endpoints return correct JSON structure:
      全エンドポイントが正しいJSON構造を返すことをテスト：
  - `GET /api/v1/sales_by_category`
  - `GET /api/v1/monthly_sales`
  - `GET /api/v1/sales_trend`
  - `GET /api/v1/product_comparison`

- [ ] Verify data calculations are accurate:
      データ計算が正確であることを確認：
  - Category totals match sum of individual sales - カテゴリ合計が個別売上の合計と一致
  - Monthly aggregations are correct - 月次集計が正確
  - Product metrics are properly calculated - 商品指標が適切に計算されている

#### 4.3 Docker Environment Testing / 4.3 Docker環境テスト
- [ ] Confirm database migrations work in Docker environment
      Docker環境でデータベースマイグレーションが動作することを確認
- [ ] Test API accessibility from frontend container
      フロントエンドコンテナからAPIアクセス可能性をテスト
- [ ] Verify seed data persistence across container restarts
      コンテナ再起動時のシードデータ永続性を確認

## Technical Notes / 技術的注意点

### Database Considerations / データベース考慮事項
- Use appropriate indexes for performance on frequently queried columns
  頻繁にクエリされるカラムのパフォーマンス用に適切なインデックスを使用
- Consider using database views or scopes for complex aggregations
  複雑な集計にはデータベースビューまたはスコープの使用を検討
- Implement proper foreign key constraints
  適切な外部キー制約を実装

### API Design Principles / API設計原則
- Follow RESTful conventions where applicable
  適用可能な場所でRESTful規約に従う
- Return consistent JSON structure across all endpoints
  全エンドポイントで一貫したJSON構造を返す
- Include appropriate HTTP status codes
  適切なHTTPステータスコードを含む
- Consider pagination for large datasets (future enhancement)
  大きなデータセットの改页功能を検討（将来の拡張）

### Performance Considerations / パフォーマンス考慮事項
- Optimize database queries to avoid N+1 problems
  N+1問題を避けるためにデータベースクエリを最適化
- Use database-level aggregations when possible
  可能な場合はデータベースレベルの集計を使用
- Consider caching for frequently accessed data
  頻繁にアクセスされるデータのキャッシングを検討

## Definition of Done / 完了条件
- [ ] All models are created with proper associations and validations
      全モデルが適切な関連付けとバリデーションで作成されている
- [ ] Database schema matches the design specification
      データベーススキーマが設計仕様と一致している
- [ ] Seed data provides realistic and comprehensive test data
      シードデータが現実的で包括的なテストデータを提供している
- [ ] All four API endpoints return correct data in the specified format
      4つのAPIエンドポイント全てが指定された形式で正しいデータを返す
- [ ] API endpoints are accessible from the frontend container
      APIエンドポイントがフロントエンドコンテナからアクセス可能
- [ ] Database operations work correctly in Docker environment
      Docker環境でデータベース操作が正しく動作する
- [ ] All endpoints respond with appropriate HTTP status codes
      全エンドポイントが適切なHTTPステータスコードで応答する
- [ ] Documentation is updated with actual endpoint URLs and sample responses
      実際のエンドポイントURLとサンプルレスポンスでドキュメントが更新されている

## Next Steps / 次のステップ
After completing this issue, the following will be ready for implementation:
この課題完了後、以下の実装準備が整います：
- Frontend dashboard components / フロントエンドダッシュボードコンポーネント
- Chart.js integration / Chart.js統合
- Data visualization implementation / データ可視化実装

## Dependencies / 依存関係
This issue depends on:
この課題は以下に依存：
- 001-feature-set-up-dev-env (completed) / 001-feature-set-up-dev-env（完了済み）

This issue enables:
この課題により可能になる：
- 003-feature-frontend-dashboard-components / 003-feature-frontend-dashboard-components
- Frontend API integration / フロントエンドAPI統合