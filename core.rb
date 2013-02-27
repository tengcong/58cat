require 'sinatra'
require 'rufus/scheduler'
require_relative 'engine/main'
require 'haml'

def generate_views
  Main.run
end

configure do
  generate_views
  scheduler = Rufus::Scheduler.start_new
  scheduler.every '30m' do
    generate_views
  end
end

def views_path
  File.dirname(__FILE__) + '/views/'
end

def file_name
  Time.now.strftime('%Y-%m-%d').to_s + '.html'
end

get '/' do
  File.open(views_path + file_name, 'r').read
end

get '/emails' do
  haml :emails
end

post '/add_email' do
  email = params[:email]
  Mailer.add_email_lists(email)
  redirect to('/emails')
end

post '/remove_email' do
  email = params[:email]
  Mailer.remove_email(email)
  redirect to('/emails')
end
