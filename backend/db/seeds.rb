# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all

# Create Products by Category
puts "Creating products..."

# Electronics (10 products)
electronics_products = [
  { name: "Laptop Pro 15", price: 150000, popularity: 9, rating: 4.8 },
  { name: "Wireless Mouse", price: 5000, popularity: 8, rating: 4.5 },
  { name: "Mechanical Keyboard", price: 12000, popularity: 7, rating: 4.3 },
  { name: "4K Monitor", price: 45000, popularity: 8, rating: 4.6 },
  { name: "Smartphone X", price: 80000, popularity: 9, rating: 4.7 },
  { name: "Wireless Earbuds", price: 15000, popularity: 9, rating: 4.4 },
  { name: "Tablet Air", price: 60000, popularity: 7, rating: 4.5 },
  { name: "Smart Watch", price: 35000, popularity: 8, rating: 4.2 },
  { name: "USB-C Hub", price: 8000, popularity: 6, rating: 4.1 },
  { name: "Portable SSD", price: 12000, popularity: 7, rating: 4.6 }
]

electronics_products.each do |product_data|
  Product.create!(
    name: product_data[:name],
    category: "Electronics",
    price: product_data[:price],
    popularity: product_data[:popularity],
    rating: product_data[:rating]
  )
end

# Books (8 products)
books_products = [
  { name: "Learning Ruby on Rails", price: 3500, popularity: 8, rating: 4.5 },
  { name: "JavaScript: The Good Parts", price: 2800, popularity: 9, rating: 4.7 },
  { name: "Clean Code", price: 4200, popularity: 9, rating: 4.8 },
  { name: "Design Patterns", price: 5200, popularity: 7, rating: 4.6 },
  { name: "The Pragmatic Programmer", price: 3800, popularity: 8, rating: 4.7 },
  { name: "You Don't Know JS", price: 3200, popularity: 8, rating: 4.4 },
  { name: "Refactoring", price: 4500, popularity: 7, rating: 4.5 },
  { name: "System Design Interview", price: 3900, popularity: 9, rating: 4.6 }
]

books_products.each do |product_data|
  Product.create!(
    name: product_data[:name],
    category: "Books",
    price: product_data[:price],
    popularity: product_data[:popularity],
    rating: product_data[:rating]
  )
end

# Clothing (12 products)
clothing_products = [
  { name: "Cotton T-Shirt", price: 2500, popularity: 8, rating: 4.3 },
  { name: "Denim Jeans", price: 8000, popularity: 9, rating: 4.5 },
  { name: "Wool Sweater", price: 12000, popularity: 7, rating: 4.4 },
  { name: "Running Shoes", price: 15000, popularity: 9, rating: 4.6 },
  { name: "Leather Jacket", price: 25000, popularity: 6, rating: 4.7 },
  { name: "Baseball Cap", price: 3000, popularity: 7, rating: 4.2 },
  { name: "Business Shirt", price: 6000, popularity: 8, rating: 4.4 },
  { name: "Casual Shorts", price: 4500, popularity: 8, rating: 4.1 },
  { name: "Winter Coat", price: 18000, popularity: 7, rating: 4.5 },
  { name: "Sneakers", price: 12000, popularity: 9, rating: 4.3 },
  { name: "Polo Shirt", price: 5500, popularity: 7, rating: 4.2 },
  { name: "Chino Pants", price: 7500, popularity: 8, rating: 4.4 }
]

clothing_products.each do |product_data|
  Product.create!(
    name: product_data[:name],
    category: "Clothing",
    price: product_data[:price],
    popularity: product_data[:popularity],
    rating: product_data[:rating]
  )
end

# Home Goods (6 products)
home_goods_products = [
  { name: "Coffee Maker", price: 15000, popularity: 8, rating: 4.5 },
  { name: "Air Purifier", price: 35000, popularity: 7, rating: 4.3 },
  { name: "Robot Vacuum", price: 45000, popularity: 9, rating: 4.6 },
  { name: "Kitchen Scale", price: 3500, popularity: 6, rating: 4.2 },
  { name: "Desk Lamp", price: 8000, popularity: 7, rating: 4.4 },
  { name: "Storage Box Set", price: 2500, popularity: 8, rating: 4.1 }
]

home_goods_products.each do |product_data|
  Product.create!(
    name: product_data[:name],
    category: "Home Goods",
    price: product_data[:price],
    popularity: product_data[:popularity],
    rating: product_data[:rating]
  )
end

puts "Created #{Product.count} products in #{Product.distinct.count(:category)} categories"

# Create Orders with seasonal trends for 12 months
puts "Creating orders with realistic seasonal trends..."

# Get all products for random selection
all_products = Product.all.to_a

# Define seasonal multipliers for each month (January = 1, December = 12)
seasonal_multipliers = {
  1 => 0.8,   # January - post-holiday slump
  2 => 0.9,   # February
  3 => 1.1,   # March - spring buying
  4 => 1.2,   # April
  5 => 1.3,   # May - peak spring
  6 => 1.1,   # June
  7 => 0.9,   # July - summer lull
  8 => 0.8,   # August
  9 => 1.0,   # September - back to school
  10 => 1.1,  # October
  11 => 1.4,  # November - pre-holiday
  12 => 1.6   # December - holiday peak
}

# Create orders for 12 months (current year)
current_year = Date.current.year
total_orders = 0

(1..12).each do |month|
  # Calculate number of orders for this month
  monthly_base_order_count = 150
  orders_this_month_count = (monthly_base_order_count * seasonal_multipliers[month]).round
  
  orders_this_month_count.times do
    # Distribute orders throughout the month
    order_date = Date.new(current_year, month, 1) + rand(28).days + rand(24).hours
    
    # Create order with temporary total (will be updated later)
    order = Order.create!(
      order_date: order_date,
      total_amount: 1 # Temporary value, will be updated after adding items
    )
    
    # Add 1-4 random items to each order
    num_items = rand(1..4)
    order_total = 0
    
    num_items.times do
      product = all_products.sample
      quantity = rand(1..3)
      # Add some price variation (±10%)
      unit_price = (product.price * (0.9 + rand(0.2))).round
      
      OrderItem.create!(
        order: order,
        product: product,
        quantity: quantity,
        unit_price: unit_price
      )
      
      order_total += quantity * unit_price
    end
    
    # Update order total
    order.update!(total_amount: order_total)
    total_orders += 1
  end
  
  puts "Created #{orders_this_month_count} orders for #{Date::MONTHNAMES[month]}"
end

puts "Created #{total_orders} total orders with #{OrderItem.count} order items"

# Display summary statistics
puts "\n=== Seed Data Summary ==="
puts "Products: #{Product.count}"
Product.group(:category).count.each do |category, count|
  puts "  #{category}: #{count} products"
end

puts "\nOrders: #{Order.count}"
puts "Order Items: #{OrderItem.count}"

# Calculate total sales by category for verification
category_sales = Product.joins(:order_items)
  .group(:category)
  .sum('order_items.quantity * order_items.unit_price')

puts "\nTotal Sales by Category:"
category_sales.each do |category, total|
  puts "  #{category}: ¥#{total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
end

puts "\nSeed data creation completed successfully!"
