class Author < ApplicationRecord
    has_many :author_book
    has_many :books, through: :author_book
end
