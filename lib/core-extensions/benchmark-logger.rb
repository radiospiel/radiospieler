require "logger"

class Logger
  class Benchmarker
    attr :msg, true
    attr :severity, true
    
    def initialize(msg, severity = :warn)
      @msg, @start = msg, Time.now
      @severity = severity
    end
    
    def runtime
      Time.now - @start
    end
    
    def to_s
      "#{msg}: #{(runtime * 1000).to_i} msecs" 
    end
  end
  
  def benchmark(msg = "Benchmark", opts = {}, &block)
    benchmarker = Benchmarker.new(msg, opts[:severity] || :warn)
    yield(benchmarker).tap do
      self.send(benchmarker.severity, benchmarker) if benchmarker.runtime > (opts[:minimum] || -1)
    end
  rescue
    warn "FAIL #{benchmarker}"
    raise
  end
end
