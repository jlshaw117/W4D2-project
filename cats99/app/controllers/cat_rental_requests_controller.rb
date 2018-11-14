class CatRentalRequestsController < ApplicationController

def new
  @cat_rental_request = CatRentalRequest.new
  render :new
end
def index
  @cat_request = CatRentalRequest.all
  render :index
end

def create
  @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
  if @cat_rental_request.save
    render json: @cat_rental_request
  else
    render :new
  end
end

private
def cat_rental_request_params
  params.require(:cat_rental_request).permit(:cat_id,:start_date,:end_date,:status)
end
end