# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  private

  def respond_with(resource, options={})
    if request.method == 'POST' && resource.persisted?
      render json: {
          message: 'Signed up successfully', 
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes] 
      }, status: :ok
    elsif request.method == 'DELETE'
      render json: {
        message: 'Account deleted successfullt'
      }, status: :ok
    else
      render json: {
        message: 'User could not be created successfull', 
        errors: resource.errors.full_messages 
      }, status: :unprocessable_entity
    end
  end  
end