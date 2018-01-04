class Users::RegistrationsController < Devise::RegistrationsController
  def create
    params[:user][:type]=params[:user][:user_type]
    super
  end
end
