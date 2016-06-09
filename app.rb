require 'pry'
require 'sinatra/base'
require 'sinatra/json'
require "./db/setup"
require "./lib/all"

class ShopDBApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    raise e
  end

  def self.reset_database
    [User, Item, Purchase].each { |klass| klass.delete_all }
  end

  def parsed_body
      @parsed_body ||= JSON.parse request.body.read
  end

  def user
    password = request.env["HTTP_AUTHORIZATION"]
    if password
      User.find_by(password: password)
    else
      halt 401
    end
  end

  post "/users" do
    User.create!(first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
  end

  post "/items" do
    Item.create!(description: params[:description], price: params[:price])
  end

  post "/items/:id/buy" do
    item = Item.where(id: params[:id]).first
    if item != nil
      user.purchases.create!(item_id: params[:id], quantity: params[:quantity])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  get "/items/:id/purchases" do
    items = Item.where(id: params[:id])
    items.first.users.to_json
  end

  delete "/items/:id" do
    item = Item.find_by(id: params[:id])
    if item.listed_by == user
      item.delete
      status 200
    else
      status 403
    end
  end
end
