class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  # Disable update user
  # TODO: Enable password update
  def update
    render json: { message: 'Update action is disabled' }, status: :forbidden
  end  

  # Disable update user
  # TODO: Enable user delete
  def destroy
    render json: { message: 'Delete action is disabled' }, status: :forbidden
  end    

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, profile_attributes: [:fullName, :nationalID, :country])
  end

  def respond_with(resource, options={})
    if request.method == 'POST' && resource.persisted?
      render json: {
          message: 'Signed up successfully', 
          data: ProfileSerializer.new(resource.profile).serializable_hash[:data][:attributes] 
      }, status: :ok   
    else
      render json: {
        message: 'User could not be created successfull', 
        errors: resource.errors.full_messages 
      }, status: :unprocessable_entity
    end
  end  
end