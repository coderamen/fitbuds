class UsersController < Clearance::UsersController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_user_details
  skip_before_action :require_user_details, only: [:new, :create, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)

    if @user.save
      sign_in(@user)
      UserMailer.welcome_email(@user).deliver_now
      flash[:success] = "healthapp account has been successfully created"
      redirect_to root_path
    else
      render 'users/new'
      flash[:danger] = "error in creation of account"
    end
  end

  def edit
    current_user_authorised?(params[:id], root_path)

    @user = User.find(params[:id])

    if @user.has_no_password
      flash[:danger] = "You need to have a password"
    end
  end

  def update
    current_user_authorised?(params[:id], root_path)

    @user = User.find(params[:id])

    update_hash = update_user_params

    # if update_hash == false due to passwords that do not match
    unless update_hash
      flash[:danger] = "Passwords do not match!"
      return redirect_to edit_user_path(params[:id])
    end

    # if remove_avatar is true
    if update_hash[:remove_avatar] == "1"
      @user.remove_avatar!
      @user.save
    end

    if @user.update(update_hash)
      flash[:success] = "Update successful"
      redirect_to root_path
    else
      flash[:danger] = "Update unsuccessful"
      redirect_to edit_user_path(@user)
    end

  end

  def destroy
    current_user_authorised?(params[:id], root_path)
		user = User.find_by_id(params[:id])
		sign_out
		user.authentications.delete_all
		user.destroy
		redirect_to root_path
  end

  private

  def new_user_params
    params.require(:user).permit(:email, :password, :name, :city, :state, :country, :age_range, :stamina, :strength, :agility, :additional_health_problems, :weekly_activity_hours, :avatar)
  end

  def update_user_params
    attr = params.require(:user).permit(:email, :name, :city, :state, :country, :stamina, :strength, :agility, :additional_health_problems, :weekly_activity_hours, :avatar, :remove_avatar)

    # convert string to integers for these attributes
    attr[:age_range] = params[:user][:age_range].to_i
    attr[:stamina] = attr[:stamina].to_i
    attr[:strength] = attr[:strength].to_i
    attr[:agility] = attr[:agility].to_i

    # check if passwords are the same if the user fills up the password form
    same_passwords = params[:user][:password] == params[:user][:retype_password]

    if params[:user][:password] != ""
      if same_passwords
        attr[:password] = params[:user][:password]
      else
        return false
      end
    end

    return attr

  end
end
