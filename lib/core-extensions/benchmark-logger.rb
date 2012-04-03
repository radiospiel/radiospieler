require "logger"

class Logger
  class Benchmarker
    attr :msg, true
    
    def initialize(msg)
      @msg, @start = msg, Time.now
    end
    
    def runtime
      Time.now - @start
    end
  end
  
  def benchmark(msg = "Benchmark", opts = {}, &block)
    benchmarker = Benchmarker.new(msg)
    r = yield(benchmarker)
    
    runtime = benchmarker.runtime
    warn "#{benchmarker.msg}: #{(runtime * 1000).to_i} msecs" if runtime > (opts[:minimum] || -1)
    r
  end
end
