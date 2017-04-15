class SignupCancelController < ApplicationController
  def index
    session["devise.user_attributes"] = nil
    redirect_to root_url
  end
end
