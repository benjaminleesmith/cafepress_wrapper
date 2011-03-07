class ProductsController < ApplicationController
  respond_to :js
  def show
    respond_with(@product = Product.find(params[:id]))
  end
end