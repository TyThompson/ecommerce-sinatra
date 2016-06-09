class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
    end
    create_table :items do |t|
      t.string :description
      t.string :price
      t.string :listed_by_id
    end
    create_table :purchases do |t|
      t.string :item_id
      t.string :user_id
      t.integer :quantity
    end
  end
end
