class ApplicationController < ActionController::Base
  before_action :doorkeeper_authorize!, :get_current_user

  protected
  def get_current_user
    @current_user = User.find_by doorkeeper_token.resource_owner_id if doorkeeper_token
  end

  def doorkeeper_unauthorized_render_options error: nil
    {
      json: {error: "Unauthorized"}
    }
  end
end
