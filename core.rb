require 'sinatra'
require 'rufus/scheduler'
require_relative 'engine/main'


def generate_views
  html_content = Main.run
  Persistenter.persistent(views_path, file_name, html_content)
end

def file_name
  Time.now.strftime('%Y-%m-%d').to_s + '.html'
end

def views_path
  File.dirname(__FILE__) + '/views/'
end

configure do
  generate_views
  scheduler = Rufus::Scheduler.start_new
  scheduler.every '3h' do
    generate_views
  end
end

get '/' do
  File.open(views_path + file_name, 'r').read
end

