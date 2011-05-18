# Copyright 2010-2011 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
#
# This file is part of CafePress Wrapper.
# CafePress Wrapper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CafePress Wrapper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.

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
