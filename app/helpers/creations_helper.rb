module CreationsHelper
  def timemap_data(creation)
    {
      start: creation.first_published_at.strftime("%Y-%m-%d"),
      placemarks: creation.fragments.map{|f| f.anchors.map{|a| a.placemarks}.flatten}.flatten,
#      placemarks: creation.fragments.*.placemarks.flatten,
      title: creation.title,
      options: {
            infoHtml: "<p>#{link_to creation.title, creation}</p><p>#{creation.fragments.map {|f| link_to('pp'+f.page_range, f)}.join(', ')}</p>",
            creationId: creation.id
          }
    }
  end
end

