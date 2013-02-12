require 'gmail'
class Mailer
  class << self
    def greate_gmail
      @gmail ||= Gmail.new('58catinfo@gmail.com', '58cat123')
    end

    def send_mail(subt, html_body)
      greate_gmail.deliver do
        to 'congteng45@gmail.com'
        subject subt
        html_part do
          content_type 'text/html; charset=utf-8'
          body html_body
        end
      end
    end

    def send_news(models)
      unless models.empty?
        send_mail('new info about cats on 58', models.map{|m|
          """
              <a href='#{m.url}'>#{m.title}<a><br>
              <img src='#{m.pictures.first}'></img>
              <hr>
          """
        })
      end
    end
  end
end
