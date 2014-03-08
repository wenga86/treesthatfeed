 module Admin::AlbumsHelper

  def index_album album
    html = <<-HTML
      <li class="album inline" id="album_#{album.id}">
      <p class="title">#{link_to truncate(album.name, :length => 28), :controller => 'admin/albums', :action => 'show', :id => album.id}</p>
      <p class="cover_image">
        #{cover_image(album)}
      </p>
      <p>
        <span class="delete">#{destroy_album_link(album)}</span>
        <span class="publisher">#{toggle_active_link(album)}</span>
        <span class="text-right float-right picture_count"><i class="icon-picture"></i> #{album.resources.length}</span>
      </p>
    </li>
    HTML
  end

  def toggle_active_link album
    link_to_remote (album.approved ? content_tag(:i, ' ', :class => 'icon-eye-open icon-white' ) + ' Published' : content_tag(:i, ' ', :class => 'icon-eye-close icon-white' ) + ' Unpublished'), :url => {:controller => 'admin/albums', :action => 'toggle_active', :id => album.id}, :html => { :class => (album.approved ? 'published  btn btn-success' : 'unpublished btn btn-warning') }
  end

  def destroy_album_link album
    link_to_remote(content_tag(:i, '', :class => 'icon-trash icon-white'), :url => {:controller => 'admin/albums', :action => 'destroy', :id => album.id}, :confirm => 'Are you sure you want to delete this album?', :method => :delete, :html => {:class => 'btn btn-danger'})
  end

  def cover_image album
    link_to image_tag((album.cover ? "#{this_blog.base_url}/files/thumb_#{album.cover.filename}" : "http://www.cliniminds.com/presentation/App_Themes/default/images/no_image_thumb.gif"), :class => 'img-polaroid'), :controller => 'admin/albums', :action => 'show', :id => album.id
  end

  def show_image(image, klass = true)
    thumb = "#{::Rails.root.to_s}/public/files/thumb_#{image.filename}"
    #thumb = "#{this_blog.base_url}/files/#{image.filename}"
    mpicture = "#{this_blog.base_url}/files/#{image.filename}"

    #image.create_thumbnail unless File.exists? thumb

    # If something went wrong with thumbnail generation, we just display a place holder
    thumbnail = (File.exists? thumb) ? "#{this_blog.base_url}/files/thumb_#{image.filename}" : "http://www.cliniminds.com/presentation/App_Themes/default/images/no_image_thumb.gif"
    # thumbnail = (File.exists? thumb) ? "#{this_blog.base_url}/files/thumb_#{image.filename}" : "#{this_blog.base_url}/files/#{image.filename}"

    picture = "<a class=\"fancybox-thumb\" rel=\"fancybox-thumb\" href=\"#{mpicture}\" title=\"#{image.itunes_subtitle}\"><img class='tumb#{' img-polaroid' if klass}' src='#{thumbnail}' "
    picture << "alt='#{this_blog.base_url}/files/#{image.filename}' /></a>"
    return picture
  end

end
