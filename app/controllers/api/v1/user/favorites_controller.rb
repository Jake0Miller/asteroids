module Api
  module V1
    module User
      class FavoritesController < ApiBaseController
        def index
          render json: current_user.favorites
        end

        def create
          data = NeoService.new.lookup(params[:neo_reference_id])
          fav = current_user.favorites.create(neo_reference_id: data[:neo_reference_id])
          render json: fav
        end
      end
    end
  end
end
