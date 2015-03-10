module SAXMachine
  class SAXHandler

    # Not a great solution; will be solved gracefully with CNVS-13964
    remove_method :normalize_name
    def normalize_name(name)
      # strip namespaces
      name = name.split(":").last
      name.gsub(/\-/, '_')
    end
  end
end

