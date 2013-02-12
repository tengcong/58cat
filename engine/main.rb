#encoding: utf-8
require_relative 'index_handler'
require_relative 'page_handler'
require_relative 'detail_handler'
require_relative 'page_model'
require_relative 'builder'
require_relative 'persistenter'
require_relative 'mailer'

class Array
  def -(another_arr)
    self.select{|e| not another_arr.include?(e)}
  end
end

module Main
  extend self

  def before
    puts 'start parse index ...'
  end

  def after
    new_info = get_new_info
    unless new_info.empty?
      Mailer.send_news(new_info)
    end
    Persistenter.last_models_arr = @models
    puts 'done !'
  end

  def construct_model_arr_from hash_set
    models = hash_set.flatten.map do |info_hash|
      model = DetailHandler.new(info_hash[:url]).catch
      model.location = info_hash[:location]
      model.title = info_hash[:title]
      model.date_time = info_hash[:date_time]
      model.url = info_hash[:url]
      model
    end
    models
  end

  def get_hash_set_of_pre_pages(page_range)
    PageHandler.get_page_url(page_range).map do |url|
      IndexHandler.new(url).catch
    end
  end

  def file_name
    Time.now.strftime('%Y-%m-%d').to_s + '.html'
  end

  def views_path
    File.expand_path('..', File.dirname(__FILE__)) + '/views/'
  end

  def models_arr
    @models = construct_model_arr_from(
      get_hash_set_of_pre_pages(1..3)
    )
  end

  def get_new_info
    @models - Persistenter.last_models_arr
  end

  def run
    before
    html = Builder.new(models_arr).build
    Persistenter.persistent(views_path, file_name, html)
    after
  end
end
