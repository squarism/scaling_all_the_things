require 'redis'

class Loader
  attr_reader :names
  def initialize
    @names = File.open("load/names.txt").lines.to_a
    @redis = Redis.new(driver: :hiredis)
  end

  def load
    @redis.pipelined do
      @names.each do |name|
        @redis.incr name
      end
    end
  end

end