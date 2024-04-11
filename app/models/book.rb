class Book < ApplicationRecord
	belongs_to :publisher
	has_many :author_book
	has_many :authors, through: :author_book

private
# Validator
	def self.validate_isbn isbn
		x = 0
		y = 0
		ten = {'X' => 10, 'x' => 10}
# isbn_10 validator
		if isbn.length = 10
		  	isbn.split("").each do |i|
				x += i.to_i
				y += x
			end
			y%11
		else

		end
	end

# Getter methods
	def self.find_book_by_isbn isbn
		book = ActiveRecord::Base.connection.execute(
			"SELECT books.*, publishers.name AS publisher,
				GROUP_CONCAT(CONCAT(authors.first_name, ' ',
					IFNULL(CONCAT(authors.middle_initial, '. '),''),
				authors.last_name, ' ')) AS writers
			FROM author_books
				LEFT JOIN books ON author_books.book_id = books.id
				LEFT JOIN authors ON author_books.author_id = authors.id
				LEFT JOIN publishers ON publishers.id = books.publisher_id
			WHERE books.isbn_13 = '#{isbn}'
				OR books.isbn_10 = '#{isbn}'
			GROUP BY books.id" 
		)

		if book.empty? || book.nil?
			response = {:response => "Error"}
		else
			response = {:response => "Success", :result => book}
		end
	end

end