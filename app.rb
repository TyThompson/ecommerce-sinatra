require 'pry'
require 'sinatra/base'
require 'sinatra/json'
require "./db/setup"
require "./lib/all"

class ShopDBApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    #binding.pry
    raise e
  end

  def self.reset_database
    [User, Item, Purchase].each { |klass| klass.delete_all }
  end

  def parsed_body
      @parsed_body ||= JSON.parse request.body.read
  end

binding.pry
  # post "/users/:name" do
  #   list = user.lists.where(title: params[:name]).first
  #   list.add_item parsed_body["name"], due_date: parsed_body["due_date"]
  #
  #   status 200
  # end
#
# r = post "/users", first_name: "New", last_name: "User", password: "password"
#
# test_users_can_add_items
#   user = make_existing_user
#   header "Authorization", user.password
#   assert_equal 0, Item.count
#
#   r = post "/items", description: "New Hotness", price: 100.00
#
#   header "Authorization", user.password
#
#   r = post "/items/#{item.id}/buy", quantity: 5
#
#
#   assert_raises ActiveRecord::RecordNotFound do
#     post "/items/99999/buy", quantity: 5
#   end
# r = delete "/items/#{item.id}"
# 3.times do |i|
#   u = User.create! first_name: i, last_name: i, password: "pass#{i}"
#   u.purchases.create! item: item, quantity: 4
# end
# r = get "/items/#{item.id}/purchases"
end
