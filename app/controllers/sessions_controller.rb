class SessionsController < Clearance::SessionsController
  # new and destroy are already inherited from clearance

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        cookies.signed[:user_id] = @user.id
        redirect_back_or root_path
      else
        flash[:danger] = "Unable to log in"
        render template: "sessions/new"
      end
    end
  end

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)

    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "You are now signed in"
    else
     user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = edit_user_path(user)
      @notice = "User created - confirm or edit details..."
    end

    sign_in(user)
    cookies.signed[:user_id] = user.id

    redirect_to @next, :notice => @notice
  end

end
