require 'nokogiri'

class GoogleCarouselParser
	def initialize(html)
		@html = html
		@doc = Nokogiri::HTML(html)
	end
	
	def parse
		carousel = @doc.css('g-scrolling-carousel')
		
		src_by_id = {}
		images_scripts = @doc.css('script').map(&:text).grep(/_setImagesSrc\(ii,s\)/)
		images_scripts.each do |script|
			script.scan(/var s='(.*?)';\s*var ii=\['(.*?)'\];_setImagesSrc\(ii,s\);/).each do |match|
				src_by_id[match[1]] = match[0].gsub('\\x3d', 'x3d')
			end
		end
		
		items = []
		if carousel.css('a.klitem').size > 0 
			items = carousel.css('a.klitem')
		else
			items = carousel.css('a.klitem-tr')
		end
		
		items.map do |item|
			o = {}
			meta = parse_meta(item)
			
			p parse_name(item)
			p item
			
			o[:name] = parse_name(item)
			o[:extensions] = parse_meta(item) unless meta.size == 0
			o[:link] = parse_link(item)
			o[:image] = parse_img(src_by_id, item)
			
			o
		end
	end
	
	private
	
	def parse_name(item)
		item.css('.kltat').text
	end
	
	def parse_meta(item)
		item.css('.klmeta').text.split(',')
	end
	
	def parse_link(item)
		'https://www.google.com' + item.attr('href')
	end
	
	def parse_img(srcs, item)
		img = item.css('img')[0]
		srcs[item.css('img')[0]['id']] unless img.nil?
	end
end