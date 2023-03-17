# Ruby Basics: A Beginner's Guide

This guide will help you further explore the basics of Ruby programming language. We will be covering more concepts and techniques, such as working with user input, file handling, error handling, and using Ruby's built-in modules.

## Introduction

In the previous Ruby intro, we learned about variables, strings, arrays, hashes, control structures, methods, and classes. With this foundation, we can now delve into more advanced topics, enhancing our understanding of Ruby and its capabilities. In this guide, we will focus on:

1. Working with user input
2. File handling
3. Error handling
4. Using built-in modules

By the end of this guide, you should have a solid understanding of these key concepts and be able to apply them in your Ruby projects. Let's get started!

## 1. Working with User Input

Ruby provides a simple way to get input from the user through the `gets` method. This method reads a line from the standard input (usually the keyboard) and returns it as a string. Here's an example:

```ruby
puts "What's your name?"
name = gets.chomp
puts "Hello, #{name}!"
```

The `chomp` method is used to remove the newline character at the end of the string returned by `gets`. This makes it easier to work with the input in subsequent code.

## 2. File Handling

Ruby provides built-in classes and methods for working with files. Some common file operations include reading, writing, and appending. Here's a brief overview of how to perform these tasks:

### Reading a file

```ruby
filename = "loftwah.txt"

File.open(filename, "r") do |file|
  file.each_line do |line|
    puts line
  end
end
```

### Writing to a file

```ruby
filename = "output.txt"
content = "This is a test."

File.open(filename, "w") do |file|
  file.write(content)
end
```

### Appending to a file

```ruby
filename = "output.txt"
content = "\nThis is another test."

File.open(filename, "a") do |file|
  file.write(content)
end
```

## 3. Error Handling

Error handling is an important aspect of programming. Ruby uses exceptions to handle errors. You can use `begin`, `rescue`, and `ensure` blocks to control the flow of your code when an exception occurs.

Here's an example:

```ruby
begin
  # Code that might raise an exception
  result = 10 / 0
rescue ZeroDivisionError => e
  puts "An error occurred: #{e.message}"
ensure
  puts "This code will always run, regardless of whether an exception was raised or not."
end
```

In this example, the code inside the `begin` block raises a `ZeroDivisionError` exception. The `rescue` block catches the exception and prints an error message. The `ensure` block is used to execute code that should always run, regardless of whether an exception occurred or not.

## 4. Using Built-in Modules

Ruby comes with a rich set of built-in modules that provide useful functionality. These modules can be included in your code using the `require` statement. Here are some examples:

### Working with dates

```ruby
require 'date'

today = Date.today
puts "Today's date is #{today}."
```

### Generating random numbers

```ruby
require 'securerandom'

random_number = SecureRandom.random_number(100)
puts "A random number between 0 and 99: #{random_number}"
```

### Working with JSON

```ruby
require 'json'

# Convert a Ruby hash to a JSON string
person = { name: "Dean", age: 37, city: "Melbourne" }
json_string = JSON.generate(person)
puts json_string

# Parse a JSON string into a Ruby hash
json_string = '{"name":"Dean","age":37,"city":"Melbourne"}'
person = JSON.parse(json_string)
puts person["name"]
```

In this example, we use the `json` module to convert a Ruby hash to a JSON string and parse a JSON string into a Ruby hash. The `JSON.generate` method is used to convert the hash to a JSON string, while the `JSON.parse` method is used to parse the JSON string back into a hash.

## Conclusion

With this guide, you have learned about working with user input, file handling, error handling, and using built-in modules in Ruby. These concepts are essential for building robust and feature-rich Ruby applications. As you continue learning and exploring Ruby, you'll undoubtedly discover even more powerful features and techniques to help you write clean, efficient, and maintainable code. Good luck on your Ruby programming journey!
