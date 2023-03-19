# Ruby Advanced Concepts: Metaprogramming and Functional Programming

In this guide, we will explore advanced concepts in Ruby programming, such as metaprogramming and functional programming. Metaprogramming allows you to write code that writes or manipulates code, while functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions.

## Introduction

In the previous guides, we covered the basics of Ruby programming and object-oriented programming. In this guide, we will dive deeper into some of the more advanced features of Ruby:

1. Metaprogramming
2. Functional Programming

By the end of this guide, you should have a solid understanding of these advanced concepts and be able to apply them in your Ruby projects. Let's get started!

## 1. Metaprogramming

Metaprogramming is a technique that allows you to write code that writes or manipulates code. In Ruby, metaprogramming is often used to create dynamic methods, define attributes, or extend classes at runtime.

Here's an example:

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?('say_')
      text = method_name.to_s[4..-1]
      puts "#{@name} says: '#{text.gsub('_', ' ')}'"
    else
      super
    end
  end
end

person = Person.new("John", 30)
person.say_hello_world
person.say_ruby_is_awesome
```

In this example, we define a `Person` class with an `initialize` method that sets the person's name and age attributes. We also define a `method_missing` method that is called whenever an undefined method is called on the object.

The `method_missing` method checks if the method name starts with "say\_" and, if so, extracts the text to be said by the person. It then prints the text with the person's name. If the method name does not start with "say\_", the method\_missing method calls the `super` method to delegate the handling of the missing method to the parent class.

We then create an instance of the `Person` class and call two undefined methods, `say_hello_world` and `say_ruby_is_awesome`. The `method_missing` method intercepts these method calls and prints the appropriate text.

## 2. Functional Programming

Functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions. It emphasizes immutability, the use of pure functions, and the avoidance of side effects.

In Ruby, you can use functional programming concepts by utilizing lambdas, procs, and higher-order functions like `map`, `reduce`, and `select`.

Here's an example:

```ruby
# Define a lambda that calculates the square of a number
square = ->(x) { x * x }

# Define an array of numbers
numbers = [1, 2, 3, 4, 5]

# Use the `map` function to apply the `square` lambda to each number in the array
squares = numbers.map(&square)

# Use the `reduce` function to calculate the sum of the squares
sum_of_squares = squares.reduce(0, :+)

# Use the `select` function to filter the numbers that are greater than 2
filtered_numbers = numbers.select { |number| number > 2 }

puts "Squares: #{squares}"
puts "Sum of squares: #{sum_of_squares}"
puts "Filtered numbers: #{filtered_numbers}"
```

In this example, we define a lambda function called `square` that calculates the square of a number. We then define an array of numbers and use the `map` function to apply the `square` lambda to each number in the array, resulting in a new array of squared numbers.

We use the `reduce` function to calculate the sum of the squares by iteratively applying the addition operation to the elements of the squared numbers array.

Lastly, we use the `select` function to filter the original numbers array, keeping only those elements that are greater than 2.

Here's the code snippet:

```ruby
# Define a lambda that calculates the square of a number
square = ->(x) { x * x }

# Define an array of numbers
numbers = [1, 2, 3, 4, 5]

# Use the `map` function to apply the `square` lambda to each number in the array
squares = numbers.map(&square)

# Use the `reduce` function to calculate the sum of the squares
sum_of_squares = squares.reduce(0, :+)

# Use the `select` function to filter the numbers that are greater than 2
filtered_numbers = numbers.select { |number| number > 2 }

puts "Squares: #{squares}"
puts "Sum of squares: #{sum_of_squares}"
puts "Filtered numbers: #{filtered_numbers}"
```

In this example, functional programming concepts are demonstrated by using lambdas, higher-order functions such as `map`, `reduce`, and `select`, and by emphasizing immutability and the use of pure functions.
