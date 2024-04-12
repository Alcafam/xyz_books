class Book < ApplicationRecord
	belongs_to :publisher
	has_many :author_book
	has_many :authors, through: :author_book

private
# ==== Validator ==== #
	def self.validate_isbn isbn
		isbn = isbn.delete "\s-"
		x = 0
		y = 0
# isbn_10 validator
		if isbn.length == 10
			z = 10
			isbn.split("").each do |i|
				if is_digit?(i)
					x = i.to_i * z
				else
					i = [i].map { |n| ten[n] }
					x = i[0].to_s.to_i * z
				end
				y += x
				z -= 1
			end
			response = y % 11 == 0 ? "valid" : {:response => "400"}

# isbn_13 validator
		elsif isbn.length == 13
			z = 0
			isbn.split("").each do |i|
				x = i.to_i * (z % 2 == 0 ? 1 : 3)
				y += x
				z += 1
			end
			puts "TOTAL = #{y}"
			response = y % 10 == 0 ? "valid" : {:response => "400"}

# invalid isbn
		else
			response = {:response => "400"}
		end
	end

	def self.ten
		{'X' => 10, 'x' => 10}
	end
	
	def self.is_digit?(s)
		code = s.ord
		48 <= code && code <= 57
	end

# ==== Getter methods ==== #
	def self.find_book_by_isbn isbn
		@validation = Book.validate_isbn(isbn)

		if @validation == "valid"
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
				response = {:response => "404"}
			else
				response = {:response => "Success", :result => book}
			end
		else
			response = @validation
		end
	end

end