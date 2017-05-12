class MatchStatusesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def create
    pending = Pending.find_by_id(params[:pending_viewer_id])
    current_user_authorised?(pending.user_id, root_path)

    @match_status = MatchStatus.new(match_status_params)

    if @match_status.save 
      # add method to check the reversed id statuses
      if @match_status.opposite_match_status_accepted?
        match = @match_status.create_new_match

        if match
          flash[:success] = "Match created!"
          return redirect_to user_match_path(user_id: pending.user_id, id: match.id)
        else
          flash[:danger] = "Unable to create match"
        end
      end

      respond_to do |format| 
        format.html { redirect_to user_pending_path(user_id: current_user.id, id: params[:pending_viewer_id].to_i) }
        format.js { @match_status = @match_status }
      end
      
    else
      respond_to do |format|
        format.html {
          flash[:danger] = "Unable to make changes"
          redirect_to user_pending_path(user_id: current_user.id, id: params[:pending_viewer_id].to_i)
        }
        format.js { @flash = "Unable to make changes" }
      end

    end

  end

  private

  def match_status_params
    hash = {
      pending_viewer_id: params[:pending_viewer_id],
      pending_viewed_id: params[:pending_viewed_id],
      status: params[:status]
    }
  end
end
