require 'rspec'
require 'json'
require_relative 'google_carousel_parser.rb'

describe 'CarouselParser' do
	describe 'parse' do
		it 'items from html' do
			input = File.open('../files/van-gogh-paintings.html', "r:UTF-8", &:read)
			output = GoogleCarouselParser.new(input).parse
			
			json_output = JSON.pretty_generate({artworks: output})
			expected_output = File.read('../files/expected-array.json')

			expect(json_output).to eq(expected_output)
		end
	end
end