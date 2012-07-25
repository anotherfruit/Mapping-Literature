#xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:geo" => "http://www.w3.org/2003/01/geo/wgs84_pos#" do
  xml.channel {
    xml.title("All Fragments")
    xml.link("http://www.example.com")
    xml.description("Fragments with Link")
    xml.language('en-us')
    for fragment in @fragments
      xml.item do
        xml.title(fragment.creation)
        xml.description(fragment , " - Page: " , fragment.page_nr_start , "-" , fragment.page_nr_end)
        xml.pubDate(fragment.creation.first_published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link( fragment_url(fragment) )
        xml.geo :lat do
          xml.text! fragment.lat.to_s
        end
        xml.geo :long do
          xml.text! fragment.long.to_s
        end
      end
    end
  }
end
