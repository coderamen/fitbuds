class PendingsController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def index
    current_user_authorised?(params[:user_id], root_path)

    @pendings = Pending.where(user_id: params[:user_id], status: "waiting").order('created_at desc')
  end

  def new
    current_user_authorised?(params[:user_id], root_path)

    @pending = Pending.new
  end

  def create
    current_user_authorised?(params[:user_id], root_path)

    pending_attrs = pending_params

    # condiiton for when the user doesn't specify an other activity
    if !pending_attrs
      flash[:danger] = "You need to specify an activity!"
      return redirect_to new_user_pending_path(user_id: current_user.id)
    end

    @pending = Pending.new(pending_attrs)
    @pending.status = "waiting"
    @pending.user_id = current_user.id

    if @pending.save
      redirect_to user_pending_path(user_id: current_user.id, id: @pending)
    else
      redirect_to new_user_pending_path(user_id: current_user.id)
    end

  end

  def show
    current_user_authorised?(params[:user_id], root_path)

    @pending = Pending.find(params[:id])
  end

  def destroy
    current_user_authorised?(params[:user_id], root_path)

    pending = Pending.find(params[:id])

    pending.delete_related_matches_matchstatuses
    pending.destroy

    redirect_to user_path(current_user)
  end

  private

  def pending_params
    return_hash = params.require(:pending).permit(:city)
    return_hash[:datetime] = get_datetime(params[:pending])

    if params[:pending][:activity_id] == "0"
      # condition for when an other activity is specified or none
      if params[:pending][:activity] != ""
        activity_id = Activity.get_id(params[:pending][:activity])
        return_hash[:activity_id] = activity_id
      else
        return false
      end
    else
      return_hash[:activity_id] = params[:pending][:activity_id].to_i
    end

    return return_hash
  end
end
