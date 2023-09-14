class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    # items = Item.all
    # render json: items, include: :user
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user, status: :ok
  end

  def show
    item = Item.find_by(id: params[:id])
    render json: item, include: :user, status: :ok
  end

  def create
    if params[:user_id]
      user = User.find(params[:id])
      item = user.items.create(item_params)
    else
      item = Item.create(item_params)
    end
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
  def render_record_not_found
    render json: {error: "Record not found"}, status: :not_found
  end

end
