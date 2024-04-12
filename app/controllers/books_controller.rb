class BooksController < ApplicationController
    def show
		@results = Book.find_book_by_isbn(params[:search])
      	
		respond_to do |format|
			puts @results[:response]
			if @results[:response] != "Success"
				format.html {render "errors/#{@results[:response]}", layout: true, status: :not_found}
				format.json {render json: @response, status: :not_found, location: @results} 
			else
				format.html { render "index", layout: true, status: :ok}
				format.json {render json: @response, status: :ok, location: @results} 
			end
		end
    end
end