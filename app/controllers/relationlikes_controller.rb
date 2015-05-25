#controlador de likes
class RelationlikesController < ApplicationController
	before_action :logged_in_user
	
	#crear likes
	def create
		@user = User.find(params[:liker_id])
		@post = Micropost.find(params[:post_id])
   		@post.like(@user)
    	redirect_to request.referer
	end
	
	#destruir likes
	def destroy
	    @user = Relationlike.find(params[:id]).liker
	    @post = Relationlike.find(params[:id]).post
	    @post.unlike(@user)
	    redirect_to request.referer
  	end
	
end
