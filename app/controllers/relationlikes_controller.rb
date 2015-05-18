class RelationlikesController < ApplicationController
	before_action :logged_in_user

	def create
		@user = User.find(params[:liker_id])
		@post = Micropost.find(params[:post_id])
   		@post.like(@user)
    	respond_to do |format|
     		format.html {redirect_to request.referrer} #a donde hay que rediriguir para que vaya bien????
      		format.js
    	end
	end

	def destroy
	    @user = Relationlike.find(params[:id]).liker
	    @post = Relationlike.find(params[:id]).post
	    @post.unlike(@user)
	    respond_to do |format|
    		format.html { redirect_to request.referrer } #a donde hay que rediriguir para que vaya bien????
      		format.js
   		 end
  	end
	
end
