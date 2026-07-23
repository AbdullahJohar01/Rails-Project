class CartItemsController < ApplicationController
  before_action :require_login

  def create
    cart = current_user.cart

    cart_item = cart.cart_items.find_by(book_id: params[:book_id])

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart.cart_items.create(
        book_id: params[:book_id],
        quantity: 1
      )
    end

    redirect_to books_path, notice: "Book added to cart."
  end

  def destroy
    cart_item = current_user.cart.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to cart_path, notice: "Item removed."
  end
end
