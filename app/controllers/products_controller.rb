class ProductsController < ApplicationController
  respond_to :js
  def show
    respond_to do |format|
      format.js {@product = Product.find(params[:id])}
      format.html {
        product = Product.find(params[:id])
        redirect_to store_url(product.store, :product_id => product.id)
      }
    end
  end
end