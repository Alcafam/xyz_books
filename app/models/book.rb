class Book < ApplicationRecord
  belongs_to :publisher
  has_many :authors, through: :author_book
end
