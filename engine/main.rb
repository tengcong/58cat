#encoding: utf-8
require_relative 'index_handler'
require_relative 'page_handler'
require_relative 'detail_handler'
require_relative 'page_model'
require_relative 'builder'
require_relative 'persistenter'

module Main
  extend self

  def before_filter
    puts 'start parse index ...'
  end

  def after_filter
    puts 'done !'
  end

  def construct_model_arr_from hash_set
    models_arr = hash_set.flatten.map do |info_hash|
      model = DetailHandler.new(info_hash[:url]).catch
      model.location = info_hash[:location]
      model.title = info_hash[:title]
      model.date_time = info_hash[:date_time]
      model.url = info_hash[:url]
      model
    end
    models_arr
  end

  def get_hash_set_of_pre_pages(page_range)
    PageHandler.get_page_url(page_range).map do |url|
      IndexHandler.new(url).catch
    end
  end

  def run
    before_filter
    models = construct_model_arr_from(
      get_hash_set_of_pre_pages(1..3)
    )

    html = Builder.new(models).build
    after_filter
    html
  end
end
