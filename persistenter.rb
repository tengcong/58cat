class Persistenter
  class << self
    def persistent(path, file_name, content)
      File.open(path + file_name, 'w') {|f| f.write(content) }
    end
  end
end
