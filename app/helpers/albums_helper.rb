module AlbumsHelper

    def index_albums album
    html = <<-HTML
      <li class="album row" id="album_#{album.id}">
        <span class="span2">#{cover_images(album)}</span>
        <div class="span5">
        <p class="title">#{link_to truncate(album.name, :length => 35), :controller => 'albums', :action => 'show', :id => album.id}</p>
        <p class="description">#{album.description || 'No Description Provided'}</p>
      </div>
    </li>
    HTML
  end

  def show_albums image
    html = <<-HTML
      <li class="image span2" id="image_#{image.id}">
        #{show_images(image)}
    </li>
    HTML
  end

  def cover_images album
    link_to image_tag((album.cover ? "#{this_blog.base_url}/files/thumb_#{album.cover.filename}" : "http://www.cliniminds.com/presentation/App_Themes/default/images/no_image_thumb.gif"), :class => 'img-polaroid'), :controller => 'albums', :action => 'show', :id => album.id
  end

  def show_images(image, klass = true)
    thumb = "#{::Rails.root.to_s}/public/files/thumb_#{image.filename}"
    #thumb = "#{this_blog.base_url}/files/#{image.filename}"
    mpicture = "#{this_blog.base_url}/files/#{image.filename}"

    #image.create_thumbnail unless File.exists? thumb

    # If something went wrong with thumbnail generation, we just display a place holder
    thumbnail = (File.exists? thumb) ? "#{this_blog.base_url}/files/thumb_#{image.filename}" : "http://www.cliniminds.com/presentation/App_Themes/default/images/no_image_thumb.gif"
    picture = "<a class=\"fancybox-thumb\" rel=\"fancybox-thumb\" href=\"#{mpicture}\" title=\"#{image.itunes_subtitle}\"><img class='tumb#{' img-polaroid' if klass}' src='#{thumbnail}' "
    picture << "alt='#{this_blog.base_url}/files/#{image.filename}' /></a>"
    return picture
  end

end
