module Rails
  class << self
    def loggers
      CustomLogger
    end
  end
end
