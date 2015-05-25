#resetar password
class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end
  #crear contraseña
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email enviado. Revise su email"
      redirect_to root_url
    else
      flash.now[:danger] = "Dirección email no encontrada"
      render 'new'
    end
  end

  def edit
  end
  #actualizar contraseña
  def update
    if password_blank?
      flash.now[:danger] = "La contraseña no puede estar vacía"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "La contraseña ha sido cambiada con éxito"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    #user_parms
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Returns true if password is blank.
    def password_blank?
      params[:user][:password].blank?
    end

    # Before filters

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "El link ha expirado"
        redirect_to new_password_reset_url
      end
    end
end
