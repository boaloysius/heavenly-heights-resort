module Api
  module V1
    class ProfileController < ApiController
      include Pagy::Backend  
      include ProfileConcern
      
      before_action :authenticate_user!
      before_action :set_profile
      load_and_authorize_resource only: [:all]
      
      def show
        render json: {data: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes]}, status: :ok
      end

      def update
        if params[:profile][:imageFile].present?
          @profile.upload_image(params[:profile][:imageFile].path)
        end        
        if @profile.update(profile_params)
          render json: {data: ProfileSerializer.new(@profile).serializable_hash[:data][:attributes]}, status: :ok
        else
          render json: {errors: @profile.errors}, status: :unprocessable_entity
        end
      end

      def all
        profiles = Profile.includes(:user).order(created_at: :desc)
      
        if params[:role].present? && ROLES.include?(params[:role])
          profiles = profiles.joins(:user).where(users: { role: params[:role] })
        end

        @pagy, profiles = pagy(profiles, limit: 10)
        
        profiles_data = profiles.map do |profile|
          ProfileSerializer.new(profile).serializable_hash[:data][:attributes]
        end
      
        render json: { data: profiles_data, pagy: pagy_metadata(@pagy) }
      end    

      def bookings
        profile = Profile.find_by(user_id: params[:user_id])
        if profile
          authorize! :bookings, profile
          bookings = profile.user.bookings.includes(user: :profile, cabin: {})
          booking_data = bookings.map do |booking|
            BookingSerializer.new(booking).serializable_hash[:data][:attributes]
          end
          render json: { data: {profile: profile, bookings:booking_data} }, status: :ok
        else
          render json: { errors: "Profile not found" }, status: :not_found
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
