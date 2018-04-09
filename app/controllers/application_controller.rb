class ApplicationController < ActionController::API
  include SerializableResource
  
  rescue_from ActionController::ParameterMissing, :with => :params_error
  rescue_from Koala::Facebook::AuthenticationError, :with => :facebook_auth_error 
  rescue_from Koala::Facebook::ClientError, :with => :facebook_auth_error 

  def facebook_auth_error
    render json: {message: 'Error al validar access token! debe volver a conectarse a facebook'}, status: :unprocessable_entity
  end

  def params_error
    render json: {message: 'Faltan parámetros'}, status: :not_found
  end 
end
