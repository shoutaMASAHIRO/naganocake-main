# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def after_sign_up_path_for(resource)
    my_page_path 
  end
 
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
  end
end
