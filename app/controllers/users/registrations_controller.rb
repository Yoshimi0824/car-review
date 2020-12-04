# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
     unless @user.valid?
       render :new and return
     end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
     unless @address.valid?
       render :new_address and return
     end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end
 
  private
 
  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :municipality, :street_number, :building_name)
  end

  
end
