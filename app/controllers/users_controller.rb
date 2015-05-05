class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page], :per_page => 15)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor revise su email para activar su cuenta! "
      redirect_to root_url
    else
      render 'new'
    end

  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end
  
    def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil Actualizado"
      redirect_to @user
    else
      render 'edit'
    end
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
        flash[:danger] = "Por favor, registrese! "
        redirect_to root_url
      end
    end
    
        # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
