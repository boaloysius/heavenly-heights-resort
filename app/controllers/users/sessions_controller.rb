# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # include RackSessionsFix

  respond_to :json

  private

  def respond_with(resource, options={})
    if current_user
      render json: {
        message: "User signed in successfully", 
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        error: "User has no active session",
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy

    if current_user
      render json: {
        message: "Signed out successfully"
      }, status: :ok
    else
      render json: {
        message: "User has no active session"
      }, status: :unauthorized
    end
  end    
end
