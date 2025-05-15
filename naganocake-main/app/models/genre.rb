class Genre < ApplicationRecord
    validates :name, presence: true,uniqueness: true

    has_many :items
    scope :only_active, -> { where(is_deleted: false) }
end