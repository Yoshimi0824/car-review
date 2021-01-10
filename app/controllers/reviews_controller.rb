class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :search_product, only: [:index, :search]

  def index
    @reviews = Review.all.order('created_at DESC').page(params[:page])
    set_review_column
  end
  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.includes(:user)
  end

  def edit
    redirect_to action: :index unless @review.user_id == current_user.id
  end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy if @review.user_id == current_user.id
    redirect_to root_path
  end

  def search
    @results = @p.result.includes(:user).order('created_at DESC')
  end

  private

  def review_params
    params.require(:review).permit(:automaker_id, :model_of_car, :grade, :era_name_id, :model_year, :design_id, :driving_performance_id, :ride_comfort_id, :lording_id, :fuel_economy_id, :price_id, :good_point, :bad_point, :image, :tag_list).merge(user_id: current_user.id)
  end
  
  def set_review
    @review = Review.find(params[:id])
  end

  def search_product
    @p = Review.ransack(params[:q]) 
  end

  def set_review_column
    @review_model_of_car = Review.select("model_of_car").distinct  # 重複なくnameカラムのデータを取り出す
  end
  
end
