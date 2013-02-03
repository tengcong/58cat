#encoding: utf-8
require_relative 'parser'
class DetailHandler < Parser
  def catch
    container = @doc.at_css('div.conleft')
    pm = PageModel.new
    # title & date_time & location
    contact_part = container.at_css('li.call_2 img')
    pm.contact = contact_part ? contact_part[:src] : '保密'
    pm.type = container.at_css('li').content

    pm.contacter = $1 if container.at_css('#newuser + script').content =~ /username:'(.+)'/
    pm.content = container.at_css('div.maincon').content
    pictures = []

    text = container.at_css('#readmore + script').content
    text.scan(/(http:\/\/.+\.jpg)/) do
      pictures << $1.gsub('tiny', 'big')
    end

    pm.pictures = pictures
    puts 'transform done ...'
    pm
  rescue Exception => e
    puts 'bug occur!'
    puts e
  end

end

