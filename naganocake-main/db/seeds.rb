# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin
Admin.find_or_create_by!(email: "a@a") do |admin|
  admin.password = "aaaaaa"
end

# Customer
Customer.find_or_create_by!(email: "a@a") do |customer|
  customer.last_name = "a"
  customer.first_name = "a"
  customer.last_name_kana = "a"
  customer.first_name_kana = "a"
  customer.postal_code = "a"
  customer.address = "a"
  customer.phone_number = "a"
  customer.password = "aaaaaa"
end

Customer.find_or_create_by!(email: "taro.sato@example.com") do |customer|
  customer.last_name = "佐藤"
  customer.first_name = "太郎"
  customer.last_name_kana = "サトウ"
  customer.first_name_kana = "タロウ"
  customer.postal_code = "1234567"
  customer.address = "東京都新宿区西新宿1-1-1"
  customer.phone_number = "08012345678"
  customer.password = "satoTR"
end

10.times do |i|
  Customer.find_or_create_by!(email: "customer#{i+1}@example.com") do |customer|
    customer.last_name = "顧客#{i+1}"
    customer.first_name = "太郎"
    customer.last_name_kana = "カスタマー#{i+1}"
    customer.first_name_kana = "タロウ"
    customer.postal_code = "123-4567"
    customer.address = "東京都渋谷区1-1-1"
    customer.phone_number = "0901234567"
    customer.password = "password"
  end
end

# ジャンルを事前に作成
cake_genre = Genre.find_or_create_by!(name: 'ケーキ') do |genre|
  genre.is_deleted = false
end

# ケーキジャンルのアイテムを作成
Item.find_or_create_by!(name: "イチゴケーキ", genre_id: cake_genre.id) do |item|
  item.introduction = "イチゴ"
  item.price = 100
  item.is_deleted = false
end

Item.find_or_create_by!(name: "チョコケーキ", genre_id: cake_genre.id) do |item|
  item.introduction = "チョコ"
  item.price = 120
  item.is_deleted = true
end

Item.find_or_create_by!(name: "抹茶ケーキ", genre_id: cake_genre.id) do |item|
  item.introduction = "抹茶"
  item.price = 400
  item.is_deleted = false
end

# 追加のケーキジャンルの商品を作成
10.times do |i|
  Item.find_or_create_by!(name: "商品#{i+1}", genre_id: cake_genre.id) do |item|
    item.introduction = "これは商品#{i+1}です。"
    item.price = 1000
    item.is_deleted = false
  end
end

# ジャンル10種類を作成
10.times do |i|
  genre = Genre.find_or_create_by!(name: "ジャンル#{i + 1}") do |g|
    g.is_deleted = false
  end

  # 各ジャンルに10個の商品を作成
  10.times do |j|
    Item.find_or_create_by!(name: "ジャンル#{i + 1}の商品#{j + 1}", genre_id: genre.id) do |item|
      item.introduction = "これはジャンル#{i + 1}の商品#{j + 1}です。"
      item.price = 100 + j * 10  # 例：100, 110, ..., 190
      item.is_deleted = false
    end
  end
end
