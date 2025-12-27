# frozen_string_literal: true

class MagicLinksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def show
    user = consume_user
    return redirect_to_failure unless user

    login_user!(user)
    redirect_to success_url, allow_other_host: true
  rescue StandardError => e
    Rails.logger.error("[magic_link] #{e.class}: #{e.message}")
    redirect_to_failure
  end

  def create
    email = params.require(:email).to_s.strip.downcase
    return render(json: { error: 'email_required' }, status: :unprocessable_entity) if email.blank?

    user = User.find_or_create_by!(email: email)
    raw_token = MagicLink.issue_for(user)
    MagicLinkMailer.login_link(user:, token: raw_token).deliver_now

    head :accepted
  rescue ActionController::ParameterMissing
    render json: { error: 'email_required' }, status: :unprocessable_entity
  end

  private

  def consume_user
    MagicLink.consume!(params[:id].to_s)
  end

  def login_user!(user)
    reset_session
    session[:user_id] = user.id
  end

  def redirect_to_failure
    redirect_to failure_url, allow_other_host: true
  end

  def success_url
    ENV.fetch('FRONTEND_URL', '/')
  end

  def failure_url
    ENV.fetch('FRONTEND_AUTH_FAILURE_URL', '/')
  end
end
