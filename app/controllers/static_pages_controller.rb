class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 15)
      @notfollow = current_user.not_follow
    end
  end

   def buscar
    
    text = params[:buscar]
    puts "#{text}"
    @user = User.where("name like '%#{text}%'").paginate(page: params[:page], :per_page => 15)
	puts "#{@user}"
  end

  def help
  end
end
