# app/controllers/api/v1/cabins_controller.rb
module Api
  module V1
    class CabinsController < ApiController
      before_action :set_cabin, only: [:show, :update, :destroy]

      def index
        @cabins = Cabin.order(created_at: :desc)
        cabins_data = @cabins.map do |cabin|
          CabinSerializer.new(cabin).serializable_hash[:data][:attributes]
        end
        render json: { data: cabins_data }        
      end

      def show
        render json: {data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes]}
      end

      def create
        @cabin = Cabin.new(cabin_params)
        if @cabin.save
          render json: {data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes]}, status: :created
        else
          render json: {errors: @cabin.errors}, status: :unprocessable_entity
        end
      end

      def update
        if @cabin.update(cabin_params)
          render json: {data: CabinSerializer.new(@cabin).serializable_hash[:data][:attributes]}
        else
          render json: {errors: @cabin.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @cabin.destroy
        head :no_content
      end

      private

      def set_cabin
        @cabin = Cabin.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Cabin not found' }, status: :not_found
      end

      def cabin_params
        params.require(:cabin).permit(:maxCapacity, :regularPrice, :discount, :name, :description, :imageFile)
      end
    end
  end
end
