class Api::V1::DashboardController < Api::V1::BaseController
  # 円グラフ用：カテゴリ別売上比率データ
  def sales_by_category
    category_sales = Product.joins(:order_items)
      .group(:category)
      .sum('order_items.quantity * order_items.unit_price')
    
    render_json_success(category_sales)
  rescue StandardError => e
    render_json_error("Failed to fetch sales by category: #{e.message}")
  end
  
  # 棒グラフ用：月次売上高データ
  def monthly_sales
    monthly_data = OrderItem.joins(:order)
      # DATE_TRUNCは'year','month','day'などで単位を指定して、例えば 2025-07-01 00:00:00 のように該当月の初日に切り捨てる
      .group("DATE_TRUNC('month', orders.order_date)")
      .sum('order_items.quantity * order_items.unit_price')
      .transform_keys { |key| key.strftime('%Y-%m') }
      .sort
    
    render_json_success(monthly_data.to_h)
  rescue StandardError => e
    render_json_error("Failed to fetch monthly sales: #{e.message}")
  end
  
  # 折れ線グラフ用：年間売上トレンドデータ
  def sales_trend
    trend_data = OrderItem.joins(:order)
      .group("DATE_TRUNC('month', orders.order_date)")
      .sum('order_items.quantity * order_items.unit_price')
      .transform_keys { |key| key.strftime('%Y-%m') }
      .sort
    
    render_json_success(trend_data.to_h)
  rescue StandardError => e
    render_json_error("Failed to fetch sales trend: #{e.message}")
  end
  
  # レーダーチャート用：商品特徴比較データ
  def product_comparison
    comparison_data = Product.select(
      :name,
      :category,
      :price,
      :popularity,
      :rating
    ).order(:category, :name)
    
    render_json_success(comparison_data)
  rescue StandardError => e
    render_json_error("Failed to fetch product comparison: #{e.message}")
  end
end