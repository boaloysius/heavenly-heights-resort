module Api
  module V1
    class CabinsController < ApiController
      before_action :authenticate_user!, only: [:create, :update]
      before_action :set_cabin, only: [:show, :update, :destroy, :bookings]
      load_and_authorize_resource

      # GET /cabins
      def index
        @cabins = Cabin.order(created_at: :desc)
        cabins_data = @cabins.map do |cabin|
          CabinSerializer.new(cabin).serializable_hash[:data][:attributes]
        end
        render json: { data: cabins_data }
      end

      # GET /cabins/:id
      def show
        render json: { data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes] }
      end

      # GET /cabins/:id/bookings
      def bookings
        @bookings = @cabin.bookings.order(created_at: :desc)
        bookings_data = @bookings.map do |booking|
          BookingSerializer.new(booking).serializable_hash[:data][:attributes]
        end
        render json: { data: bookings_data }
      end

      # POST /cabins
      def create
        @cabin = Cabin.new(cabin_params)
        if params[:cabin][:imageFile].present?
          @cabin.upload_image(params[:cabin][:imageFile].path)
        end
        if @cabin.save
          render json: { data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes] }, status: :created
        else
          render json: { errors: @cabin.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /cabins/:id
      def update
        if params[:cabin][:imageFile].present?
          @cabin.upload_image(params[:cabin][:imageFile].path)
        end
        if @cabin.update(cabin_params)
          render json: { data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes] }
        else
          render json: { errors: @cabin.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /cabins/:id
      def destroy
        if @cabin.bookings.exists?
          render json: { message: "Cannot delete cabin with existing bookings." }, status: :unprocessable_entity
        else
          @cabin.destroy
          render json: { message: "Cabin deleted successfully." }, status: :ok
        end
      end

      private

      def set_cabin
        @cabin = Cabin.find(params[:id])
      end

      def cabin_params
        params.require(:cabin).permit(:maxCapacity, :regularPrice, :discount, :name, :description)
      end
    end
  end
end
