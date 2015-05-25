#paginas estaticas
class StaticPagesController < ApplicationController
  #pagina principal
  def home
    if logged_in? # si esta logeado el usuario busca sus microposts, los feeds y las sugerencias
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 15)
      @notfollow = current_user.not_follow
    end
  end

   #metodo para buscar usuarios
   def buscar
    text = params[:buscar]
    @user = User.where("name like '%#{text}%'").paginate(page: params[:page], :per_page => 15)
   end
  
  #ayuda
  def help
  end
end
