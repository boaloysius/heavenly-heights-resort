module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from CanCan::AccessDenied, with: :handle_access_denied
  end

  private

  def handle_record_not_found(exception)
    model_name = exception.model
    case model_name
    when 'Booking'
      render json: { error: 'Booking not found' }, status: :not_found
    when 'Profile'
      render json: { error: 'Profile not found' }, status: :not_found
    when 'Cabin'
      render json: { error: 'Cabin not found' }, status: :not_found
    else
      render json: { error: 'Record not found' }, status: :not_found
    end
  end

  def handle_access_denied(exception)
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
