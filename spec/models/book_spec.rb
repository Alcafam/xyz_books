require 'rails_helper'

RSpec.describe 'ISBN' do
# TEST CASE FOR VALIDATORS
	it "is a valid ISBN" do
		@result = Book.validate_isbn("9781537138589")
		expect(@result).to eq("valid")
	end

	it "is a 400 error request for ISBN search" do
		@result = Book.validate_isbn("adwd21324dw")
		expect(@result).to eq(:response => "400")
	end

# TEST CASE FOR SEARCH TRANSACTION
  	it "is a 404 error request for ISBN search" do
		books = Book.create( 
			title: "Test project",
			isbn_13: "978-1-53713-858-9",
			isbn_10: "1-537-13858-8",
			price: 500,
			year_published: 2016, 
			image: "9781537138589.jpg",
			edition: nil,
			publisher_id: 1
		)
		@result = Book.find_book_by_isbn("1891830023")
		expect(@result).to eq(:response => "404")
	end

# TEST CASE FOR CONVERTERS
	it "is a correct convertion of isbn13 to isbn10" do
		@result = Book.convert_isbn("9781603090384")
		expect(@result).to eq("160309038X")
	end

	it "is a correct convertion of isbn10 to isbn13" do
		@result = Book.convert_isbn("160309038X")
		expect(@result).to eq("9781603090384")
	end

# TEST CASE FOR OTHER METHODS
	it "is a digit" do
		@result = Book.is_digit?("231")
		expect(@result).to eq(true)
	end

	it "is not a digit" do
		@result = Book.is_digit?("x2")
		expect(@result).to eq(false)
	end
end