module Api
  module V1
    class ProfileController < ApiController
      before_action :authenticate_user!
      before_action :set_profile
      
      def show
        render json: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes], status: :ok
      end

      def update
        if @profile.update(profile_params)
          render json: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes], status: :ok
        else
          render json: {errors: @profile.errors}, status: :unprocessable_entity
        end
      end

      private

      def set_profile
        @profile = current_user.profile
      end

      def profile_params
        params.require(:profile).permit(:fullName, :nationalID, :country)
      end
    end
  end
end
