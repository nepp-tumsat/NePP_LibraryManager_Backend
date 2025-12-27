# frozen_string_literal: true

class SessionsController < ApplicationController
  def show
    if current_user
      render json: { id: current_user.id, email: current_user.email, name: current_user.name }
    else
      render json: { user: nil }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    head :no_content
  end
end
