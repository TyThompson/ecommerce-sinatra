class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  # belongs_to :listed_by_id
end
