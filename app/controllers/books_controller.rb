class BooksController < ApplicationController
    def show
		@results = Book.find_book_by_isbn(params[:search])
      	
		respond_to do |format|
		puts @results[:result]
			if @results[:response] == "empty"
				redirect_to "/"
				format.json {render json: @results, status: :ok} 
			elsif @results[:response] != "Success"
				format.html {render "errors/#{@results[:response]}", layout: true, status: :not_found}
				format.json {render json: @results, status: :not_found} 
			else
				@book = @results[:result]
				format.html { render "index", layout: true, status: :ok}
				format.json {render json: @results, status: :ok} 
			end
		end
    end
end