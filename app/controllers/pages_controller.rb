class PagesController < ApplicationController
  def home
    if user_signed_in?
      render 'pages/timeline'
    else
      @minimum_password_length = Devise.password_length.min
      render 'devise/registrations/new'
    end
  end

  # helpers

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
