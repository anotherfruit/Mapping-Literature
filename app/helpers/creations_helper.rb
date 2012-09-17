module CreationsHelper
  def timemap_data(creation)
    {
      start: creation.first_published_at.strftime("%Y-%m-%d"),
      placemarks: creation.fragments.map{|f| f.anchors.map{|a| a.placemarks}.flatten}.flatten,
#      placemarks: creation.fragments.*.placemarks.flatten,
      title: creation.title,
      options: {
            infoHtml: "#{link_to creation.title, creation}: #{creation.fragments.map {|f| link_to('pg'+f.page_range, f)}.join(', ')}",
            creationId: creation.id
          }
    }
  end
end

