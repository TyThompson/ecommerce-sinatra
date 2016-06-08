class Item < ActiveRecord::Base
  # belongs_to :purchase

  has many :users, through: :purchases
  has_many :purchases
end
