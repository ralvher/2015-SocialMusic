#post
class MicropostsController < ApplicationController
  	before_action :logged_in_user, only: [:create, :destroy]
  	before_action :correct_user,   only: :destroy
	
	#crear post
	def create    
		@micropost = current_user.microposts.build(micropost_params)

		if @micropost.save
		  flash[:success] = "¡Creado correctamente!"
		  redirect_to root_url
		else
		  @feed_items = []
		  flash[:danger] = "¡No se ha podido crear el post!"
		  redirect_to root_url
		end
	end

	#destruir post
	def destroy
		@micropost.destroy
		flash[:success] = "¡Eliminado con éxito!"
		redirect_to request.referrer || root_url
	end
  
  
private
    #parametros micropost
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    #usuario correcto
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end