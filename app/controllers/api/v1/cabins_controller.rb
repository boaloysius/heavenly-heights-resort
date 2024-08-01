module Api
  module V1
    class CabinsController < ApiController
      before_action :authenticate_user!, only: [:create, :update]

      # Authorize for actions
      before_action :set_cabin, only: [:show, :update, :destroy]
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

      # POST /cabins
      def create
        @cabin = Cabin.new(cabin_params)
        if @cabin.save
          render json: { data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes] }, status: :created
        else
          render json: { errors: @cabin.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /cabins/:id
      def update
        if @cabin.update(cabin_params)
          render json: { data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes] }
        else
          render json: { errors: @cabin.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /cabins/:id
      def destroy
        @cabin.destroy
        head :no_content
      end

      private

      def set_cabin
        @cabin = Cabin.find(params[:id])
      end

      def cabin_params
        params.require(:cabin).permit(:maxCapacity, :regularPrice, :discount, :name, :description, :imageFile)
      end
    end
  end
end
