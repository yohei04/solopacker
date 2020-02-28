class Users::ProfilesController < ApplicationController
  def index
    @users = User.all
    @q = @users.ransack(params[:q])
    @paginated_users = @q.result(distinct: true).page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Save profile successfully.'
    else
      render 'edit'
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
