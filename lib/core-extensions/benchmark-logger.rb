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
  end
  
  def benchmark(msg = "Benchmark", opts = {}, &block)
    benchmarker = Benchmarker.new(msg, opts[:severity] || :warn)
    r = yield(benchmarker)
    
    runtime = benchmarker.runtime
    if runtime > (opts[:minimum] || -1)
      self.send benchmarker.severity, "#{benchmarker.msg}: #{(runtime * 1000).to_i} msecs" 
    end
    r
  rescue
    warn "FAIL #{benchmarker.msg}: #{(runtime * 1000).to_i} msecs" 
    raise
  end
end
