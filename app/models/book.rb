class Book < ApplicationRecord
	belongs_to :publisher
	has_many :author_book
	has_many :authors, through: :author_book

private
# ==== Validator ==== #
	def self.validate_isbn isbn
		x = 0
		y = 0
# isbn_10 validator
		if isbn.length == 10
			z = 10
			isbn.split("").each do |i|
				if is_digit?(i)
					x = i.to_i * z
				else
					i = i == "X" || i == "x" ? 10:i
					x = i.to_i * z
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
			response = y % 10 == 0 ? "valid" : {:response => "400"}

		elsif isbn.empty?
			response = {:response => "empty"}
# invalid isbn
		else
			response = {:response => "400"}
		end
	end

# ==== Getter methods ==== #
	def self.find_book_by_isbn isbn
		isbn=isbn.delete "\s-"
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
				WHERE REPLACE(books.isbn_13,'-','') = '#{isbn}'
					OR REPLACE(books.isbn_10,'-','') = '#{isbn}'
				GROUP BY books.id" 
			)[0]
			if !book
				response = {:response => "404"}
			else
				book["converted_isbn"] = convert_isbn(isbn)
				response = {:response => "Success", :result => book, }
			end
		else
			response = @validation
		end
	end

# ==== Other Methods ==== #

	def self.is_digit?(s)
		code = s.ord
		48 <= code && code <= 57
	end

# ==== Converter ==== #
	def self.convert_isbn isbn
		isbn = isbn.delete "\s-"
		x = 0
		y = 0
	  
# isbn 10 to 13
		if isbn.length == 10
			isbn = "978" + isbn.chomp(isbn[isbn.length-1])
			z=0
			isbn.split("").each do |i|
				x = i.to_i * (z % 2 == 0 ? 1 : 3)
				y += x
				z += 1
			end
			y = 10-(y%10)
			isbn = "#{isbn}"+"#{y}"
		else
			isbn = isbn.chomp(isbn[isbn.length-1]).sub!("978", "")
			z = 10
			isbn.split("").each do |i|
				x = i.to_i * z
				y += x
				z -= 1
				z = z==1 ? 0:z 
			end
			y = ((11-y)%11)%11 == 10 ? 'X':((11-y)%11)%11
			isbn = "#{isbn}"+"#{y}"
		end
	end
end