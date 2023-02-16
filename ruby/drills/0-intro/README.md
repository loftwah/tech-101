# Ruby Intro

Ruby is a dynamic, object-oriented programming language that emphasizes simplicity and productivity. It was created in the mid-1990s by Yukihiro Matsumoto, also known as Matz, and has since become one of the most popular programming languages in the world.

## Getting Started

To get started with Ruby, you will need to have Ruby installed on your machine. You can download the latest version of Ruby from the [official Ruby website](https://www.ruby-lang.org/en/downloads/).

Once you have Ruby installed, you can open a Ruby interactive shell by running the following command in your terminal:

`irb`

This will open the interactive shell where you can enter Ruby code and see the output immediately.

## Syntax

Ruby has a simple and elegant syntax that is easy to read and write. Here are some basic examples of Ruby syntax:

```ruby
# Variables
name = "Loftwah"
age = 37

# Strings
greeting = "Hello, #{name}!"
puts greeting

# Arrays
teams = ["nuggets", "heat", "lakers"]
puts teams[1]

# Hashes
person = { name: "Tuan", age: 21 }
puts person[:name]
```

This code defines a `name` variable with the value `"Loftwah"`, an `age` variable with the value `37`, and a `greeting` variable that uses string interpolation to include the `name` variable in the string. It also defines an array of `teams` and a hash of `person`.

## Control Structures

Ruby provides a variety of control structures for managing the flow of execution in your code. Here are some examples:

```ruby
# If-else statements
if age >= 18
  puts "You are an adult"
else
  puts "You are a child"
end

# Loops
teams = ["nuggets", "heat", "lakers"]
teams.each do |team|
  puts team
end

# While loop
i = 0
while i < 10
  puts i
  i += 1
end
```

This code uses an `if-else` statement to check if the `age` variable is greater than or equal to `18`. It also uses a `each` loop to iterate over the `teams` array and print each team. Finally, it uses a `while` loop to print the numbers from 0 to 9.

## Methods

In Ruby, you can define methods to encapsulate blocks of code and make them reusable. Here is an example:

```ruby
def add(a, b)
  return a + b
end

sum = add(3, 5)
puts sum
```

This code defines an `add` method that takes two parameters, `a` and `b`, and returns their sum. It then calls the `add` method with the arguments `3` and `5` and stores the result in the `sum` variable.

## Classes

Ruby is an object-oriented programming language, which means that it provides support for classes and objects. Here is an example of a Ruby class:

```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

person = Person.new("Loftwah", 37)
person.say_hello
```

This code defines a `Person` class with two attributes, `name` and `age`, and a `say_hello` method that prints a greeting using the attributes. It then creates a new instance of the `Person` class with the `name` and `age` values of `"Loftwah"` and `30`, and calls the `say_hello` method on the instance.

## Conclusion

Ruby is a powerful and expressive programming language that is easy to learn and use. Its simple syntax, rich set of built-in features, and strong community support make it a great choice for a wide range of programming tasks, from scripting and automation to web development and data analysis. If you're new to programming or looking to learn a new language, Ruby is definitely worth considering!
