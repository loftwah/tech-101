class FizzBuzz
    def initialize(start, finish)
      @start = start
      @finish = finish
    end
  
    def call
      (@start..@finish).each do |i|
        output = ''
        output << 'Fizz' if i % 3 == 0
        output << 'Buzz' if i % 5 == 0
        puts output.empty? ? i : output
      end
    end
  end
  
  FizzBuzz.new(1, 100).call
  