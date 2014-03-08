class AlbumSidebar < Sidebar
  description \
    "Adds sidebar links to photo album in the body of the page"

  def photos
    @albums ||= Album.all.sort_by {|t| t.name}
  end
  # attr_accessor :asins

  # def parse_request(contents, request_params)
  #   asin_list = contents.to_a.map do |item|
  #     item.whiteboard[:asins].to_a
  #   end.flatten
  #   self.asins = asin_list.uniq.compact[0,maxlinks.to_i]
  # end
end
