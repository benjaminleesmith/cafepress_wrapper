xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:content' => 'http://purl.org/rss/1.0/modules/content/' do
  xml.channel do
    xml.title "#{Rails.configuration.cpw_name} - #{Rails.configuration.cpw_title}"
    xml.description Rails.configuration.cpw_description
    xml.link root_url

    for store in @stores
      xml.item do
        xml.title truncate(store.description, :length => 50, :separator => ' ')
        xml.description store.description
        if store.cafepress_back_design_url
          xml.tag! 'content:encoded' do
            xml.cdata! %{
              <a href="#{store_url(store)}">
                <img src="#{store.cafepress_design_url}"/>
              </a>
              <br/>
              <a href="#{store_url(store)}">
                <img src=#{store.cafepress_back_design_url}/>
              </a>
              <br/>
              <p>#{store.description}</p>
            }
          end
        else
          xml.tag! 'content:encoded' do
            xml.cdata! %{
              <a href="#{store_url(store)}">
                <img src="#{store.cafepress_design_url}"/>
              </a>
              <br/>
              <p>#{store.description}</p>
            }
          end
        end
        xml.pubDate store.created_at
        xml.link store_url(store)
        xml.guid store.cafepress_store_id
      end
    end
  end
end
