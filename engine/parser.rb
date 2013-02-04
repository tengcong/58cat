require 'nokogiri'
require 'open-uri'

class Parser
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end
end
