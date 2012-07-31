module FragmentsHelper
  def fragment_timemap_data(fragment)
    if fragment.gpscoordsets.count > 0
      case fragment.shape
      when "way"
        placemarks = [
                      {
                        polyline: fragment.gpscoordsets.map do |gpscoordset|
                          {lat: gpscoordset.lat, lon: gpscoordset.long}
                        end
                      }
                     ] + fragment.gpscoordsets.map do |gpscoordset|
                       {
                         point: {
                           lat: gpscoordset.lat,
                           lon: gpscoordset.long
                         }
                       }
                     end
        {
          start: fragment.creation.first_published_at.strftime("%Y-%m-%d"),
          placemarks: placemarks,
          title: "#{fragment.creation} - #{fragment.to_s}",
          options: {
            description: "<br/>&quot;I'm a fragment that outlines a way&quot;<br/><br/>#{link_to 'Link to Fragment', fragment}<br/>#{link_to 'Link to Book', fragment}",
            theme: "red",
            fragmentId: fragment.id,
            creationId: fragment.creation.id
          }
        }
      when "multipoint"
        {
          start: fragment.creation.first_published_at.strftime("%Y-%m-%d"),
          placemarks: fragment.gpscoordsets.map do |gpscoordset|
            {
              point: {
                lat: gpscoordset.lat,
                lon: gpscoordset.long
              }
            }
          end,
          title: "#{fragment.creation} - #{fragment.to_s}",
          options: {
            description: "<br/>&quot;I'm a multi-point fragment that outlines a horizon&quot;<br/><br/>#{link_to 'Link to Fragment', fragment}<br/>#{link_to 'Link to Book', fragment}",
            theme: "blue",
            fragmentId: fragment.id,
            creationId: fragment.creation.id
          }
        }
      when "space"
        {
          start: fragment.creation.first_published_at.strftime("%Y-%m-%d"),
          polygon: fragment.gpscoordsets.map do |gpscoordset|
            {
              lat: gpscoordset.lat,
              lon: gpscoordset.long
            }
          end,
          title: "#{fragment.creation} - #{fragment.to_s}",
          options: {
            description: "<br/>&quot;I'm a fragment outlining space!&quot;<br/><br/>#{link_to 'Link to Fragment', fragment}<br/>#{link_to 'Link to Book', fragment}",
            theme: "orange",
            fragmentId: fragment.id,
            creationId: fragment.creation.id
          }
        }
      end
    end
  end

  def way_placemarks
  end



end
