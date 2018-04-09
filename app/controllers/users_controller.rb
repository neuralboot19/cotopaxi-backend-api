class UsersController < ApplicationController
  before_action :set_user, only: [:show, :vote]

  def show
    render json: @user
  end

  # POST /users
  def create
    if user_params[:facebook_access_token]
      graph = Koala::Facebook::API.new(user_params[:facebook_access_token])
      user_data = graph.get_object("me", {:fields => 'email,picture.type(large), name'})
      user = User.find_by(email: user_data["email"])
      if user
        render json: user, status: :ok
      else
        user = User.new(email: user_data["email"],
                        full_name: user_data["name"],
                        picture: user_data["picture"]["data"]["url"],
                        facebook_access_token: user_params[:facebook_access_token])
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end
    else
      render json: {message: 'Debe colocar un access token'}, status: :unprocessable_entity
    end
  end

  def vote
    if @user.candidate_id.nil?
      if candidate_params[:id]
        @user.update_attribute(:candidate_id, candidate_params[:id])
        render json: { message: "Su voto fue para #{@user.candidate.full_name}"}, status: :ok
      else
        render json: { message: 'Faltan parámetros'}, status: :not_found
      end
    else
      render json: { message: 'Usted ya ha votado'}, status: :unprocessable_entity
    end
  end

  private
    def set_user
      graph = Koala::Facebook::API.new(request.headers["AUTH-TOKEN"])
      user_data = graph.get_object("me", {:fields => 'email,picture.type(large), name'})
      @user = User.find_by(email: user_data["email"])
      return @user if @user
      render json: { message: 'Error de autenticación, el token inválido'}, status: :unauthorized
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:facebook_access_token)
    end

    def candidate_params
      params.require(:candidate).permit(:id)
    end
end
