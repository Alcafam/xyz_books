class Author < ApplicationRecord
    has_many :books, through :author_books
end
