class StoreController < ApplicationController
    skip_before_filter :authorize

  def index
    if session[:user_id]
      @user =User.find_by_id(session[:user_id])
    end
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
   else
    @products = Product.order(:title)
    @cart = current_cart

  end
 end
end
    
