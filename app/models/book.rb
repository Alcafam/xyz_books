class Book < ApplicationRecord
  belongs_to :publishers
  has_many :authors, through: :author_book
end
