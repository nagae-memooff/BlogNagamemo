module ConnectionBackTraceTracer
  attr_accessor :backtrace_array

  def backtrace_array
    @backtrace_array ||= {before: nil, after: nil, in: nil}
  end

  def self.save_backtrace_to key
    backtrace_array[key] = Thread.current.backtrace_array
  end
end
