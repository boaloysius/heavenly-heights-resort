# app/controllers/api/v1/cabins_controller.rb
module Api
  module V1
    class CabinsController < ApiController
      before_action :set_cabin, only: [:show, :update, :destroy]

      def index
        @cabins = Cabin.order(created_at: :desc)
        render json: { data: @cabins }
      end

      def show
        render json: {data: @cabin}
      end

      def create
        @cabin = Cabin.new(cabin_params)
        if @cabin.save
          render json: {data: @cabin}, status: :created
        else
          render json: {errors: @cabin.errors}, status: :unprocessable_entity
        end
      end

      def update
        if @cabin.update(cabin_params)
          render json: {cabin: @cabin}
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
        params.require(:cabin).permit(:maxCapacity, :regularPrice, :discount, :name, :image, :description)
      end
    end
  end
end
