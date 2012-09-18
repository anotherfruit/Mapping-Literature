module CreationsHelper
  def timemap_data(creation)
    {
      start: creation.first_published_at.strftime("%Y-%m-%d"),
      placemarks: creation.fragments.map{|f| f.anchors.map{|a| a.placemarks}.flatten}.flatten,
#      placemarks: creation.fragments.*.placemarks.flatten,
      title: creation.title,
      options: {
            description: "#{link_to 'Link to Book', creation}",
            creationId: creation.id
          }
    }
  end
end

