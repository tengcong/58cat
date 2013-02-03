require_relative 'parser'
class IndexHandler < Parser

  def catch
    [].tap do |e|
      @doc.css('.tblist > tr').each do |item|
        next unless td = item.at_css('td.t')
        next unless td.at_css('span.tu')

        a = td.at_css('a')
        url = a[:href]
        title = a.content
        date_time = item.at_css('td.pd').content
        location = td.at_css('span.area a').content
        puts "#{url}"

        e.push({:url => url, :title => title, :date_time => date_time, :location => location})
      end
    end
  end

end

