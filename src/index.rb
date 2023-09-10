#! /usr/bin/env ruby

require 'nokogiri'
require 'json'
require_relative 'google_carousel_parser.rb'

pp GoogleCarouselParser.new(File.open('../files/van-gogh-paintings.html')).parse

# pp GoogleCarouselParser.new(File.open('../files/impressionist-artists.html')).parse
# pp GoogleCarouselParser.new(File.open('../files/female-impressionist-artists.html')).parse