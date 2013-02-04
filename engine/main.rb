#encoding: utf-8
require_relative 'index_handler'
require_relative 'page_handler'
require_relative 'detail_handler'
require_relative 'page_model'
require_relative 'builder'
require_relative 'persistenter'

module Main
  extend self

  def run
    puts 'start parse index ...'
    hash_set = PageHandler.get_page_url(1..3).map do |url|
      IndexHandler.new(url).catch
    end

    models = hash_set.flatten.map do |info_hash|
      model = DetailHandler.new(info_hash[:url]).catch
      model.location = info_hash[:location]
      model.title = info_hash[:title]
      model.date_time = info_hash[:date_time]
      model.url = info_hash[:url]
      model
    end

    Builder.new(models).build

  end
end
