class AlbumsController < ContentController
  # before_filter :login_required, :only => [:preview, :preview_page]
  # before_filter :auto_discovery_feed, :only => [:show, :index]
  before_filter :verify_config

  layout :theme_layout, :except => [:comment_preview, :trackback]

  # cache_sweeper :blog_sweeper
  # caches_page :index, :read, :archives, :view_page, :redirect, :if => Proc.new {|c|
  #   c.request.query_string == ''
  # }

  def index
    @albums = Album.active

  end

  def show
    @album = Album.find(params[:id])

  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(params[:album])
    @album.save

    redirect_to :action => :show, :controller => 'admin/albums', :id => @album.id
  end

  private

   def verify_config
    if  ! this_blog.configured?
      redirect_to :controller => "setup", :action => "index"
    elsif User.count == 0
      redirect_to :controller => "accounts", :action => "signup"
    else
      return true
    end
  end



end
