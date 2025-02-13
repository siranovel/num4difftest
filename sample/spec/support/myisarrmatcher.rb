# 配列
module MyIsArrMatcher
  class Matcher
    def initialize(expected)
      @expected = expected
    end
    def matches?(actual)
        @actual = actual
        return @actual == @expected 
    end
    def failure_message
      "#{@expected} expected but got #{@actual}"
    end

  end
  class Matcher2
    def initialize(expected, n)
      @expected = expected
      @n = n
    end
    def matches?(actual)
        @actual = actual
        a = @actual.length
        ret = true

        a.times do |i|
            a[i].times do |j|
                w = @actual[i][j]
                if @expected[i][j] != w.round(@n) then
                    ret = false
                end
            end
        end
        return ret
    end
    def failure_message
      "#{@expected} expected but got #{@actual}"
    end
  end
  def is_array(expected)
    Matcher.new(expected)
  end
  def is_rounds(expected, n)
    Matcher2.new(expected, n)
  end
end

