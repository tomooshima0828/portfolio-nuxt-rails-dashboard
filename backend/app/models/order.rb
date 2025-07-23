class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :order_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
end
