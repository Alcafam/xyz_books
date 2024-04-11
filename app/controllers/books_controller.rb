class BooksController < ApplicationController
    def show
		isbn = params[:search].delete "\s-"
		@validation = Book.validate_isbn(isbn)
		# if @validation.valid?
		# 	flash[:notice] = "Message sent! Thank you for contacting us."

		# else
		# 	flash[:notice] = "Error"
		# end
      	# @results = Book.find_book_by_isbn(isbn)
		# puts @results[:response]
		render json: @validation
		# render "index"
    end
end
