class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :custom_logout
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
  end

  def custom_logout
    if current_user&.need_logout?
      Redis.new.del("logout_#{current_user.id}")
      sign_out(current_user)
      redirect_to root_path
    end
  end
end
