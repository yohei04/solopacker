class Users::ProfilesController < ApplicationController
  include Map

  before_action :authenticate_user!

  def index
    @q = User.with_attached_image.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @recruits = @user.recruits
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Save profile successfully.'
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :user_name, :email,
                                   :date_of_birth, :gender, :origin,
                                   :current_country, :current_city,
                                   :language_1, :language_2, :language_3,
                                   :introduce, :image)
    end
end
