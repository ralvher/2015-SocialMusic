class SessionsController < ApplicationController

  def new
  end

  def create

    auth = request.env["omniauth.auth"]
    if auth
      puts "email ----> #{auth["info"]["email"]}"
      user = User.find_by(email: auth["info"]["email"]) || nuevo=User.create_with_omniauth(auth)
      log_in user
      if nuevo        
        flash[:success] = "Bienvenido a SocialMusic!"
      end
      redirect_back_or user
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or user
        else
          message  = "Cuenta no activada "
          message += "Revise su email"
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Email inválido / Contraseña incorrecta'
        render 'static_pages/home'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end