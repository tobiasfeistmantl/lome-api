json.active_relationship @user.following.find_by(id: params[:partner_id]).present?
json.passive_relationship @user.follower.find_by(id: params[:partner_id]).present?