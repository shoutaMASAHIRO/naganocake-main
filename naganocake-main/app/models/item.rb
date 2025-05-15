class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :oder_details, dependent: :destroy
  belongs_to :genre

  has_one_attached :image

  # バリデーション
  # validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, numericality: true
  # validates :genre_id, presence: { message: "を入力してください" }

  # その他のメソッド
  def get_item_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample1.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * 1.1).floor
  end

  def self.recommended
    recommends = []
    active_genres = Genre.only_active.includes(:items)
    active_genres.each do |genre|
      item = genre.items.last
      recommends << item if item
    end
    recommends
  end
end
