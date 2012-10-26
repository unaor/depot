class StoreController < ApplicationController
    
  def index
    @time = Time.current
    @products=Product.order(:title)
  end
end
