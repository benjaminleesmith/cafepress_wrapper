class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
  end

  def index
    @stores = Store.all
  end
end
