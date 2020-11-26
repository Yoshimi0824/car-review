class ReviewsController < ApplicationController
  def new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def review_params
    params.permit(:automaker_id, :model_of_car, :grade, :era_name_id, :model_year, :design_id, :driving_performance_id, :ride_comfort_id, :lording_id, :fuel_economy_id, :price_id, :good_point, :bad_point, :image).merge(user_id: current_user.id)
  end
  
end
