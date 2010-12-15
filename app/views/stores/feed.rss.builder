xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rockclimbingshirts.com - funny, awesome, and badass climbing shirts"
    xml.description "Hilarious, sweet, and all around kickass shirts for every type of rock climber."
    xml.link root_url

    for store in @stores
      xml.item do
        xml.title truncate(store.description, :length => 50, :separator => ' ')
        xml.description store.description
        xml.pubDate store.created_at
        xml.link "http://cafepress.com/#{store.cafepress_store_id}"
        xml.guid store.cafepress_store_id
      end
    end
  end
end
