#encoding: utf-8
require 'gmail'

class Mailer
  @@email_lists = [
    'congteng45@gmail.com',
    'lixiaoyang1026@gmail.com'
  ]
  class << self

    def email_lists
      @@email_lists
    end

    def add_email_lists email
      @@email_lists << email
    end

    def remove_email email
      @@email_lists.delete(email)
    end

    def greate_gmail
      @gmail ||= Gmail.new('58catinfo@gmail.com', '58cat123')
    end

    def send_mail(subt, html_body)
      greate_gmail.deliver do
        to email_lists
        subject subt
        html_part do
          content_type 'text/html; charset=utf-8'
          body html_body
        end
      end
      puts "sended emails to #{email_lists}"
    end

    def send_news(models)
      unless models.empty?
        send_mail('58同城最新猫猫领养信息提示', models.map{|m|
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
