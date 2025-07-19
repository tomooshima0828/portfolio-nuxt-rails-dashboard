# Requirements Specification: Sales Dashboard Application
# 要件定義書：売上ダッシュボードアプリケーション

---

## 1. Overview
## 1. 概要

The purpose of this project is to develop a sales data visualization dashboard application to learn skills for drawing various types of graphs.

本プロジェクトは、様々な種類のグラフ描画スキルを習得することを目的とした、売上データを可視化するダッシュボードアプリケーションを開発する。

---

## 2. Functional Requirements
## 2. 機能要件

### 2.1. Graph Display Function
### 2.1. グラフ表示機能

The following four types of graphs will be displayed on the dashboard.

以下の4種類のグラフをダッシュボードに表示する。

*   **Pie Chart:** Visualize the sales ratio by product category.
    *   **円グラフ:** 商品カテゴリ別の売上比率を可視化する。
*   **Bar Chart:** Visualize monthly sales figures.
    *   **棒グラフ:** 月次の売上高を可視化する。
*   **Line Chart:** Visualize the sales trend throughout the year.
    *   **折れ線グラフ:** 年間を通した売上トレンドを可視化する。
*   **Radar Chart:** Compare and visualize the characteristics (price, popularity, rating, etc.) of each product.
    *   **レーダーチャート:** 各商品の特徴（価格、人気、評価など）を比較・可視化する。

### 2.2. Data Requirements
### 2.2. データ要件

*   **Product Data:** Contains attributes such as category, price, popularity, and rating.
    *   **商品データ:** カテゴリ、価格、人気、評価などの属性情報を持つ。
*   **Sales Data:** Contains information such as product ID, sale date, and sale amount.
    *   **売上データ:** 商品ID、売上日、売上金額などの情報を持つ。
*   Prepare demo data suitable for graph display as initial data.
    *   初期データとして、グラフ表示に適したデモデータを準備する。

---

## 3. Non-functional Requirements
## 3. 非機能要件

### 3.1. Technology Stack
### 3.1. 技術スタック

*   **Frontend:**
    *   Framework: Nuxt.js (Vue.js)
    *   Language: TypeScript
    *   Styling: Tailwind CSS
    *   Graph Library: Chart.js (vue-chartjs)
*   **フロントエンド:**
    *   フレームワーク: Nuxt.js (Vue.js)
    *   言語: TypeScript
    *   スタイリング: Tailwind CSS
    *   グラフライブラリ: Chart.js (vue-chartjs)

*   **Backend:**
    *   Framework: Ruby on Rails 8 (API Mode)
    *   Database: PostgreSQL
*   **バックエンド:**
    *   フレームワーク: Ruby on Rails 8 (APIモード)
    *   データベース: PostgreSQL

### 3.2. API Endpoints
### 3.2. APIエンドポイント

The backend will provide the following API endpoints.

バックエンドは以下のAPIエンドポイントを提供する。

*   `GET /api/v1/sales_by_category`: Returns sales data by category.
    *   `GET /api/v1/sales_by_category`: カテゴリ別売上データを返す。
*   `GET /api/v1/monthly_sales`: Returns monthly sales data.
    *   `GET /api/v1/monthly_sales`: 月次売上データを返す。
*   `GET /api/v1/sales_trend`: Returns sales trend data.
    *   `GET /api/v1/sales_trend`: 売上トレンドデータを返す。
*   `GET /api/v1/product_comparison`: Returns product comparison data.
    *   `GET /api/v1/product_comparison`: 商品比較データを返す。
