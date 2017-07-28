class ApplicationController < ActionController::Base
  before_action :doorkeeper_authorize!, :current_user

  protected
  def current_user
    @current_user = User.find_by id: doorkeeper_token.resource_owner_id if doorkeeper_token
  end

  def doorkeeper_unauthorized_render_options error: nil
    {
      json: {error: "Unauthorized"}
    }
  end
end
