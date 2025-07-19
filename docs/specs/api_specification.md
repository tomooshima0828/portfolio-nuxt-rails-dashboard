# API Specification
# API設計書

---

## 1. Base URL
## 1. ベースURL

`/api/v1`

---

## 2. Authentication
## 2. 認証

No authentication is required for this version.

このバージョンでは認証は不要です。

---

## 3. Endpoints
## 3. エンドポイント

### 3.1. Get Sales by Category
### 3.1. カテゴリ別売上取得

*   **Endpoint:** `GET /sales_by_category`
*   **Description:** Retrieves sales data aggregated by product category.
*   **説明:** 商品カテゴリ別に集計された売上データを取得します。

#### Response (200 OK)

```json
{
  "data": [
    { "category": "Electronics", "sales": 35000 },
    { "category": "Books", "sales": 22000 },
    { "category": "Clothing", "sales": 18000 },
    { "category": "Home Goods", "sales": 25000 }
  ]
}
```

### 3.2. Get Monthly Sales
### 3.2. 月次売上取得

*   **Endpoint:** `GET /monthly_sales`
*   **Description:** Retrieves monthly sales data for the current year.
*   **説明:** 今年度の月次売上データを取得します。

#### Response (200 OK)

```json
{
  "data": [
    { "month": "January", "sales": 120000 },
    { "month": "February", "sales": 150000 },
    { "month": "March", "sales": 180000 }
  ]
}
```

### 3.3. Get Sales Trend
### 3.3. 売上トレンド取得

*   **Endpoint:** `GET /sales_trend`
*   **Description:** Retrieves sales data over a specific period to show trends.
*   **説明:** 特定期間の売上データを取得してトレンドを示します。

#### Response (200 OK)

```json
{
  "data": [
    { "date": "2023-01-01", "sales": 4000 },
    { "date": "2023-01-02", "sales": 4200 },
    { "date": "2023-01-03", "sales": 3800 }
  ]
}
```

### 3.4. Get Product Comparison
### 3.4. 商品比較データ取得

*   **Endpoint:** `GET /product_comparison`
*   **Description:** Retrieves comparison data for multiple products.
*   **説明:** 複数の商品の比較データを取得します。

#### Response (200 OK)

```json
{
  "data": [
    { "product": "Laptop", "price": 1500, "popularity": 8, "rating": 4.5 },
    { "product": "Mouse", "price": 50, "popularity": 9, "rating": 4.8 },
    { "product": "Keyboard", "price": 100, "popularity": 7, "rating": 4.2 }
  ]
}
```
