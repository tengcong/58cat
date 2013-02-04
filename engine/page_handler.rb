class PageHandler
  # 58 pattern parser
  # http://bj.58.com/cwzengsong/?key=%E7%8C%AB&final=1
  # http://bj.58.com/cwzengsong/pn2/?key=%E7%8C%AB&final=1
  # page pattern
  #
  class << self
    def get_page_url(range)
      [].tap do |s|
        range.each do |n|
          s << (base_path  + page(n) + '?' + key)
        end
      end
    end

    def key
      'key=%E7%8C%AB&final=1'
    end

    def base_path
      'http://bj.58.com/cwzengsong/'
    end

    def page(num)
      num == 1 ? '' : "pn#{num}/"
    end
  end
end
