# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::Cookies

  before_action :set_csrf_cookie

  private

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = session[:user_id] && User.find_by(id: session[:user_id])
  end
end
