module Api
  module V1
    class BookingsController < ApiController
      before_action :authenticate_user!
      before_action :set_booking, only: [:show, :update, :destroy]
      load_and_authorize_resource

      # GET /bookings
      def index
        @bookings = Booking.accessible_by(current_ability)
        booking_data = @bookings.map do |booking|
          BookingSerializer.new(booking).serializable_hash[:data][:attributes]
        end
        render json: { data: booking_data }
      end

      # GET /bookings/:id
      def show
        render json: { data: BookingSerializer.new(@booking).serializable_hash[:data][:attributes] }
      end

      # POST /bookings
      def create
        @booking = current_user.admin? ? Booking.new(admin_booking_params) : current_user.bookings.build(booking_params)

        if @booking.save
          render json: { data: BookingSerializer.new(@booking).serializable_hash[:data][:attributes] }, status: :created
        else
          render json: {errors: @booking.errors}, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /bookings/:id
      def update
        params_to_use = current_user.admin? ? admin_booking_params : booking_params
        if @booking.update(params_to_use)
          render json: { data: BookingSerializer.new(@booking).serializable_hash[:data][:attributes] }
        else
          render json: {errors: @booking.errors}, status: :unprocessable_entity
        end
      end

      # DELETE /bookings/:id
      def destroy
        @booking.destroy
        render json: { message: "Booking Deleted Successfully." }
      end

      private

      def set_booking
        @booking = Booking.find(params[:id])
        authorize! :read, @booking
      end

      def booking_params
        params.require(:booking).permit(:start_date, :end_date, :num_guests, :cabin_id, :has_breakfast, :observations)
      end

      def admin_booking_params
        params.require(:booking).permit(:user_id, :start_date, :end_date, :num_guests, :cabin_id, :has_breakfast, :is_paid, :status, :observations)
      end
    end
  end
end
