class ReviewsController < ApplicationController
  def new
  end

  def create
    @review = Review.new(review_params)
  end

  private

  def review_params
    require(:review).permit(:automaker_id, :model_of_car, :grade, :era_name_id, :model_year, :design_id, :driving_performance_id,
                            :ride_comfort_id, :lording_id, :fuel_economy_id, :good_point, :bad_point, :image)
                    .merge(user_id: current_user.id)
  end
  
end
