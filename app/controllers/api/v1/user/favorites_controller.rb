module Api
  module V1
    module User
      class FavoritesController < ApiBaseController
        def index
          render json: current_user.favorites
        end
      end
    end
  end
end
