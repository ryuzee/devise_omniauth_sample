class SignupCancelController < ApplicationController
  def index
    # session["devise.user_attributes"] = nil
    reset_session
    redirect_to root_url
  end
end
