class PagesController < ApplicationController

	def index
		
	end 

	def error_404
		if params[:path] && params[:path] == "500"
			render 'error_500'
		end 
	end 

	def error_500
    	
  	end 
end
