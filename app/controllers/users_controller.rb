class UsersController < ApplicationController
  def index
    if current_user.type == 'Client'
      @users = Consultant.all
    elsif current_user.type == 'Consultant'
      #@users = Client.all
      @users = current_user.myclients.group('id')
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
