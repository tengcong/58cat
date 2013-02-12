require 'ostruct'
class PageModel < OpenStruct
  # attr_accessor :title
  # attr_accessor :contact
  # attr_accessor :contacter
  # attr_accessor :location
  # attr_accessor :type
  # attr_accessor :content
  # attr_accessor :pictures
  # attr_accessor :url

  def ==(another_model)
    if self.respond_to?(:url) && another_model.respond_to?(:url)
      return (url == another_model.url)
    else
      false
    end
  end
end
