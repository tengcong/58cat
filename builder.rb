#encoding: utf-8
require 'nokogiri'
class Builder
  def initialize(page_models)
    @models = page_models
  end

  def build
    puts 'start to build ...'
    @builder = Nokogiri::HTML::Builder.new(:encoding => 'UTF-8') do |doc|
      doc.html do
        doc.head do
          doc.head.meta(:content => "text/html; charset=utf-8")
        end
        body(doc)
      end
    end
    @builder.to_html
  end

  def format_each(doc, model)
    doc.h1 model.title
    doc.img(:src => model.contact)
    doc.br
    doc.h5 model.contacter, :style => 'display: inline'
    doc.h5 model.location, :style => 'display: inline'
    doc.h5 model.type, :style => 'display: inline'
    doc.h5 model.content
    doc.a 'detail', :href => model.url
    doc.br
    model.pictures.each do |img|
      doc.img(:src => img)
      doc.br
    end
  end

  def body(doc)
    doc.div do
      @models.each do |model|
        puts "start #{model.title}"
        format_each(doc, model)
        doc.hr
      end
    end
  end
end
