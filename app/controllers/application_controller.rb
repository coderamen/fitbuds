class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def require_login
    unless signed_in?
      flash[:danger] = "You need to sign in first!"
      redirect_to sign_in_path
    end
  end

  def require_user_details
    if current_user.has_nil_attributes
      flash[:danger] = "You're missing some details"
      redirect_to edit_user_path(current_user)
    end
  end

  def current_user_authorised?(id, path)
    if current_user.id != id.to_i
      flash[:danger] = "Unathorised action."
      return redirect_to path
    end
  end

  def current_user_authorised_for_match?(match)
    if match && (current_user.id == match.user1_id || current_user.id == match.user2_id)
      return true
    else
      flash[:danger] = "Unathorised action."
      return redirect_to root_path
    end
  end

  # get datetime object from separated date and time values
  def get_datetime(params)
    date = params[:date].to_date
    time = params[:time].to_time

    day = date.day
    month = date.month
    year = date.year

    hour = time.hour
    min = time.min

    Time.local(year, month, day, hour, min, 0)
  end
end
