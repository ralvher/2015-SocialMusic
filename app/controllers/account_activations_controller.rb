#control de activaciones de cuenta
class AccountActivationsController < ApplicationController
#editar
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "¡Bienvenid@ a SocialMusic!"
      redirect_to user
    else
      flash[:danger] = "¡Link de activación inválido!"
      redirect_to root_url
    end
  end
end
