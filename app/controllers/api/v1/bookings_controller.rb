module Api
  module V1
    class BookingsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_booking, only: [:show, :update, :destroy]

      # GET /bookings
      def index
        bookings = current_user.bookings
        render json: bookings
      end

      # GET /bookings/:id
      def show
        render json: @booking
      end

      # POST /bookings
      def create
        @booking = current_user.bookings.build(booking_params)

        if @booking.save
          render json: @booking, status: :created
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /bookings/:id
      def update
        if @booking.update(booking_params)
          render json: @booking
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      # DELETE /bookings/:id
      def destroy
        @booking.destroy
        head :no_content
      end

      private

      def set_booking
        @booking = current_user.bookings.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Booking not found' }, status: :not_found       
      end

      def booking_params
        params.require(:booking).permit(:start_date, :end_date, :num_nights, :num_guests, :cabin_price, :extras_price, :total_price, :cabin_id, :has_breakfast, :is_paid, :status, :observations)
      end
    end
  end
end
