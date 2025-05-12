class Recipe < ApplicationRecord
  has_many :bookmarks

  validates :description, presence: true
  validates :name, presence: true, uniqueness: true
  validates :rating, presence: { message: "cannot be blank" }
  validates :rating, inclusion: { in: 0..5, message: "should be between 0 to 5" }
end
