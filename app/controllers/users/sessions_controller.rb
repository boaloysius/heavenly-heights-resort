class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource && resource.persisted?
      render json: {
        message: "User signed in successfully", 
        data: ProfileSerializer.new(resource.profile).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        error: "Invalid email or password"
      }, status: :unprocessable_entity
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
