class ApiController < ApplicationController
  include CanCan::ControllerAdditions
  
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end