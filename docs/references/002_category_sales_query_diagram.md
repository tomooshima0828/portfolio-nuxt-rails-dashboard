# Category Sales Query Diagram
# カテゴリ別売上クエリ図解

## SQL Query
```sql
SELECT
    products.category,
    SUM(order_items.quantity * order_items.unit_price) AS sum_id
FROM products
INNER JOIN order_items ON order_items.product_id = products.id
GROUP BY products.category
```

## Table Relationships
```mermaid
erDiagram
    products ||--o{ order_items : "has many"
    products {
        bigint id PK
        string name
        string category
        integer price
        integer popularity
        float rating
    }
    order_items {
        bigint id PK
        bigint product_id FK
        bigint order_id FK
        integer quantity
        integer unit_price
    }
```

## Query Processing Flow
```mermaid
flowchart TD
    A[products テーブル] --> B[INNER JOIN]
    C[order_items テーブル] --> B
    B --> D[結合結果<br/>products.id = order_items.product_id]
    D --> E[GROUP BY products.category]
    E --> F[SUM quantity × unit_price<br/>各カテゴリごと]
    F --> G[最終結果<br/>category, sum_id]
```

## Data Flow Example
```mermaid
graph LR
    subgraph "products table"
        P1["id:1<br/>name:'iPhone'<br/>category:'Electronics'"]
        P2["id:2<br/>name:'T-shirt'<br/>category:'Clothing'"]
        P3["id:3<br/>name:'Book'<br/>category:'Books'"]
    end
    
    subgraph "order_items table"
        O1["product_id:1<br/>quantity:2<br/>unit_price:85000"]
        O2["product_id:1<br/>quantity:1<br/>unit_price:80000"]
        O3["product_id:2<br/>quantity:3<br/>unit_price:2300"]
        O4["product_id:3<br/>quantity:1<br/>unit_price:3500"]
    end
    
    P1 --> O1
    P1 --> O2
    P2 --> O3
    P3 --> O4
```

## GROUP BY Processing
```mermaid
graph TD
    A[結合後のデータ] --> B{GROUP BY category}
    
    B --> C[Electronics グループ]
    B --> D[Clothing グループ]
    B --> E[Books グループ]
    
    C --> C1["iPhone: 2×85000 = 170000<br/>iPhone: 1×80000 = 80000<br/>合計: 250000"]
    D --> D1["T-shirt: 3×2300 = 6900<br/>合計: 6900"]
    E --> E1["Book: 1×3500 = 3500<br/>合計: 3500"]
    
    C1 --> F[Electronics: 250000]
    D1 --> G[Clothing: 6900]
    E1 --> H[Books: 3500]
```

## Step-by-Step Processing
```mermaid
sequenceDiagram
    participant DB as Database Engine
    participant P as products table
    participant OI as order_items table
    
    DB->>P: SELECT products.*
    DB->>OI: SELECT order_items.*
    DB->>DB: INNER JOIN ON product_id
    
    Note over DB: 結合後のデータセット作成
    
    DB->>DB: GROUP BY products.category
    
    Note over DB: カテゴリごとにグループ化
    
    loop Each Category Group
        DB->>DB: SUM(quantity * unit_price)
    end
    
    DB->>DB: Generate final result
    
    Note over DB: 最終結果:<br/>Electronics: ¥151,100,462<br/>Clothing: ¥47,223,032<br/>Books: ¥11,883,986<br/>Home Goods: ¥41,940,910
```

## Active Record vs Raw SQL
```mermaid
graph TB
    subgraph "Active Record"
        AR1[Product.joins:order_items]
        AR2[.group:category]
        AR3[.sum'quantity * unit_price']
        AR1 --> AR2
        AR2 --> AR3
    end
    
    subgraph "Generated SQL"
        SQL1[SELECT products.category]
        SQL2[FROM products INNER JOIN...]
        SQL3[GROUP BY products.category]
        SQL4[SUM quantity * unit_price]
        SQL1 --> SQL2
        SQL2 --> SQL3
        SQL3 --> SQL4
    end
    
    AR3 -.->|generates| SQL4
```

## Performance Considerations
```mermaid
mindmap
  root((Query Performance))
    Indexes
      products.id (PK - auto indexed)
      order_items.product_id (FK - should be indexed)
      products.category (GROUP BY - consider index)
    Join Strategy
      INNER JOIN (excludes orphaned records)
      Hash Join vs Nested Loop
    Aggregation
      SUM operation on large datasets
      Memory usage for grouping
    Data Volume
      Products: 36 records
      Order Items: 4,948 records
      Result: 4 categories
```

## Use Cases in Application
```mermaid
graph LR
    A[Category Sales Query] --> B[Pie Chart Data]
    A --> C[Dashboard Summary]
    A --> D[Sales Report]
    A --> E[Business Analytics]
    
    B --> F[Chart.js Pie Chart]
    C --> G[Admin Dashboard]
    D --> H[Monthly Report]
    E --> I[Performance KPIs]
```

## SQL Result Structure and Hash Conversion
## SQL結果構造とHash変換

### SELECT句とHash構造の対応
```sql
SELECT
    products.category,                                    -- ← キー (key)
    SUM(order_items.quantity * order_items.unit_price)   -- ← 値 (value)
FROM products
INNER JOIN order_items ON order_items.product_id = products.id
GROUP BY products.category
```

### SQL実行結果からActive Record Hashへの変換

#### SQL実行結果（テーブル形式）
```
| category    | sum_id      |
|-------------|-------------|
| Electronics | 151100462   |
| Clothing    | 47223032    |
| Books       | 11883986    |
| Home Goods  | 41940910    |
```

#### Active RecordのHash変換
```ruby
{
  "Electronics" => 151100462,  # category(key) => sum_id(value)
  "Clothing"    => 47223032,
  "Books"       => 11883986,
  "Home Goods"  => 41940910
}
```

### 一般的なパターン例

#### パターン1: GROUP BY + COUNT
```sql
SELECT category, COUNT(*) FROM products GROUP BY category
```
```ruby
# 結果のHash
{"Electronics" => 10, "Books" => 8, "Clothing" => 12}
```

#### パターン2: GROUP BY + SUM
```sql
SELECT category, SUM(price) FROM products GROUP BY category  
```
```ruby
# 結果のHash
{"Electronics" => 500000, "Books" => 30000, "Clothing" => 80000}
```

#### パターン3: GROUP BY + AVG
```sql
SELECT category, AVG(rating) FROM products GROUP BY category
```
```ruby
# 結果のHash
{"Electronics" => 4.5, "Books" => 4.6, "Clothing" => 4.2}
```

### Hash変換の仕組み
```mermaid
graph LR
    A[SQL実行結果] --> B[Active Record処理]
    B --> C[Hash変換]
    
    subgraph "SQL結果"
        D["カラム1: category<br/>カラム2: sum_id"]
    end
    
    subgraph "Hash構造"
        E["key: category値<br/>value: sum_id値"]
    end
    
    D --> E
```

### 重要なポイント

1. **SELECT句の順序**: 最初のカラムが**キー**、2番目のカラムが**値**
2. **GROUP BY**: キーになるカラムでグループ化
3. **集計関数**: 値になる部分（SUM, COUNT, AVG等）
4. **Active Record**: 自動的にHashに変換

### 確認方法
```ruby
# 実際の変換確認
result = Product.joins(:order_items)
                .group(:category)
                .sum('order_items.quantity * order_items.unit_price')

puts result.class    # => Hash
puts result.keys     # => ["Electronics", "Clothing", "Books", "Home Goods"]  
puts result.values   # => [151100462, 47223032, 11883986, 41940910]

# Hash操作例
result.each do |category, sales|
  puts "#{category}: ¥#{sales}"
end
```