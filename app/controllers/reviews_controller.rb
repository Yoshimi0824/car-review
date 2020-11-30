class ReviewsController < ApplicationController
  
  def index
    @reviews = Review.all.order('created_at DESC')
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
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
    redirect_to action: :index unless @review.user_id == current_user.id
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy if @review.user_id == current_user.id
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:automaker_id, :model_of_car, :grade, :era_name_id, :model_year, :design_id, :driving_performance_id, :ride_comfort_id, :lording_id, :fuel_economy_id, :price_id, :good_point, :bad_point, :image).merge(user_id: current_user.id)
  end
  
end
