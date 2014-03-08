class Admin::AlbumsController < Admin::BaseController

  respond_to :html, :js

  def index
    @album = Album.new
    @albums = Album.order("id desc")
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])

    if @album.save
      respond_with(@album) do |format|
        format.html { flash[:success] = "Album successfully created, you may start adding images" and redirect_to :controller => 'admin/albums', :action => 'show', :id => @album.id }
        format.js { }
      end
    else
      respond_with(@album) do |format|
        format.html { flash[:error] = "Error creating album" and redirect_to :back }
        format.js { }
      end
    end

  end

  def edit
    @album = Album.find(params[:id])
  end

  def  show
    @album = Album.find(params[:id])
    @image = @album.resources.new
    @images = @album.resources.order('id DESC').delete_if{|i| i.id.nil? }
  end

  def update

  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    respond_with(@album)
  end

  def edit_caption
    @image = Resource.find(params[:id])
    respond_with(@image) do |format|
      format.html {}
      format.js {}
    end
  end

  def update_caption
    @image = Resource.find(params[:id])
    @image.update_attribute(:itunes_subtitle, params[:resource][:itunes_subtitle])
    respond_with(@image) do |format|
      format.html { redirect_to :action => :show, :controller => 'admin/albums', :id => @image.resourcable.id }
      format.js { }
    end
  end

  def toggle_active
    @album = Album.find(params[:id])
    @album.toggle_approved
    respond_with(@album)
  end

  def cover
    @album = Album.find(params[:id])
    @image = Resource.find(params[:image_id])

    if @image.present?
      @album.update_attribute(:cover_id, @image.id)
    end

    render :update do |page|
      page << "jQuery('#cover_#{@image.id}').addClass('selected').children('i').removeClass('icon-white');"
    end
    # respond_with(@album)
  end

end
