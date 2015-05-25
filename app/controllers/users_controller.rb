class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  #cada vez que se accede al index se buscan los  usuarios
  def index
    @users = User.paginate(page: params[:page], :per_page => 15)
  end
  
  #cada vez que se accede a show se busca el usuario y sus microposts
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 15)
  end

  #crea un nuevo usuario
  def new
    @user = User.new
  end

  #crea un usuario comprobando si este ya ha realizado previamente el registo
  def create

    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "¡Por favor revise su email para activar su cuenta! "
      redirect_to root_url
    else
      render 'new'
    end

  end
  
  #elimina usuario
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "¡Usuario eliminado!"
    redirect_to users_url
  end

  #busca al usario en editar
  def edit
    @user = User.find(params[:id])
  end

  #actualiza un perfil
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil Actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #mustra los usuarios escuchados
  def following
    @title = "Escuchando"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], :per_page => 15)
    render 'show_follow'
  end

  #muestra los usuarios oyentes
  def followers
    @title = "Oyentes"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 15)
    render 'show_follow'
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
      # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location      
        flash[:danger] = "¡Por favor, registrese! "
        redirect_to root_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    #comprueba si es el admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
