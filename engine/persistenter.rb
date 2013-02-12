class Persistenter
  class << self
    def persistent(path, file_name, content)
      File.open(path + file_name, 'w') {|f| f.write(content) }
    end

    def last_models_arr=(models)
      @models = models
    end

    def last_models_arr
      @models || []
    end
  end
end
