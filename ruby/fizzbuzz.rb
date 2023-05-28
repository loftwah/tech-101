class FizzBuzz
  def initialize(start, finish)
    @start = start
    @finish = finish
    @responses = {
      0 => proc { |i| 'FizzBuzz' },
      3 => proc { |i| 'Fizz' },
      5 => proc { |i| 'Buzz' },
      6 => proc { |i| 'Fizz' },
      9 => proc { |i| 'Fizz' },
      10 => proc { |i| 'Buzz' }
    }
  end

  def call
    (@start..@finish).each do |i|
      output = @responses[i % 15].call(i) rescue i
      puts output
    end
  end
end

FizzBuzz.new(1, 100).call
