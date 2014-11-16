require 'fog'

class Admin::ResourcesController < Admin::BaseController
  upload_status_for :file_upload, :status => :upload_status

  respond_to :html, :js

  cache_sweeper :blog_sweeper

  def upload
    if request.post? && params[:upload]
      file =  params[:album_id].present? ? params[:upload] : params[:upload][:filename]

      unless file.content_type
        mime = 'text/plain'
      else
        mime = file.content_type.chomp
      end

      if params[:album_id].present?
        @album = Album.find(params[:album_id])
        @up = @album.resources.create(:filename => file.original_filename, :mime => mime, :created_at => Time.now)
        @album.update_attribute(:cover_id, @up.id) if first_image = @album.resources.size == 0
      else
        @up = Resource.create(:filename => file.original_filename, :mime => mime, :created_at => Time.now)
      end
      @up.upload file

      @message = _('File uploaded: ')+ file.size.to_s
    end

    respond_with(@album) do |format|
        format.html { finish_upload_status "'#{@message}'" }
        format.js {
          render :update do |page|
            page.insert_html :top, "images", {:partial => "admin/albums/show_image", :locals => {:image => @up, :album => @album} } if @up.present?
            page << "jQuery('h2.align-center').remove();"
          end
        }
    end

  end

  def update
    @resource = Resource.find(params[:resource][:id])
    @resource.attributes = params[:resource]

    if request.post? and @resource.save
      flash[:notice] = _('Metadata was successfully updated.')
    else
      flash[:error] = _('Not all metadata was defined correctly.')
      @resource.errors.each do |meta_key,val|
        flash[:error] << "<br />" + val
      end
    end
    redirect_to :action => 'index'
  end

  def upload_status
    render :inline => "<%= upload_progress.completed_percent rescue 0 %> % " + _("complete"), :layout => false
  end

  def index
    @r = Resource.new
    @resources = Resource.order('created_at DESC').page(params[:page]).per(this_blog.admin_display_elements)
  end

  def get_thumbnails
    position = params[:position].to_i
    @resources = Resource.without_images.by_created_at.limit("#{position}, 10")
    render 'get_thumbnails', :layout => false
  end

  def mdestroy
    #binding.pry
    delete_us = params[:image].select{|k,v| v == '1'}
    @album = Album.find(params[:id])
    @images = Resource.destroy_all(:id => delete_us.collect{|k,v| k})
    @album.cover rescue @album.update_attribute(:cover_id, nil)

    respond_with(@album) do |format|
        format.html { redirect_to :back }
        format.js { }
    end

  end

  def destroy
    begin
      @record = Resource.find(params[:id])
      mime = @record.mime
      return(render 'admin/shared/destroy') unless request.post?

      @record.destroy
      redirect_to :action => 'index'
    rescue
      raise
    end
  end
end
