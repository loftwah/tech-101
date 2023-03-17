# Ruby Basics: Object-Oriented Programming

In this guide, we will explore object-oriented programming (OOP) in Ruby. OOP is a powerful programming paradigm that allows you to write code in terms of objects and their interactions. Ruby is a fully object-oriented language, so it's a great choice for learning OOP concepts.

## Introduction

In the previous guides, we covered the basics of Ruby programming, including variables, control structures, methods, and built-in modules. In this guide, we will take things to the next level by introducing you to the world of object-oriented programming in Ruby.

In this guide, we will cover the following topics:

1. Classes and Objects
2. Attributes and Methods
3. Inheritance and Polymorphism
4. Access Modifiers

By the end of this guide, you should have a solid understanding of these key concepts and be able to apply them in your Ruby projects. Let's get started!

## 1. Classes and Objects

In Ruby, everything is an object, and every object belongs to a class. A class is a blueprint for creating objects of a particular type. Objects are instances of a class.

Here's an example:

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    puts "Hello, my name is #{@name}, and I'm #{@age} years old."
  end
end

person = Person.new("John", 30)
person.say_hello
```

In this example, we define a `Person` class with an `initialize` method that sets the person's name and age attributes. We also define a `say_hello` method that prints a message with the person's name and age.

We then create an instance of the `Person` class and call the `say_hello` method.

## 2. Attributes and Methods

In Ruby, objects have attributes and methods. Attributes are properties of an object, while methods are actions that an object can perform.

Here's an example:

```ruby
class Dog
  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def bark
    puts "Woof!"
  end

  def display_info
    puts "My name is #{@name}, and I'm a #{@breed}."
  end
end

dog = Dog.new("Rover", "Labrador")
dog.bark
dog.display_info
```

In this example, we define a `Dog` class with two attributes, `name` and `breed`. We also define two methods, `bark` and `display_info`. The `bark` method simply prints "Woof!", while the `display_info` method prints the dog's name and breed.

We then create an instance of the `Dog` class and call the `bark` and `display_info` methods.

## 3. Inheritance and Polymorphism

In Ruby, classes can inherit from other classes. Inheritance is a powerful concept that allows you to create new classes that are based on existing classes.

Here's an example:

```ruby
class Animal
  def make_sound
    puts "Some generic sound"
  end
end

class Cat < Animal
  def make_sound
    puts "Meow"
  end
end

class Dog < Animal
  def make_sound
    puts "Woof"
  end
end

cat = Cat.new
dog = Dog.new

cat.make_sound
dog.make_sound
```

In this example, we define an `Animal` class with a `make_sound` method that prints a generic sound. We then define two classes, `Cat` and `Dog`, that inherit from `Animal`. Each of these classes overrides the `make_sound` method to provide a specific sound for that animal.

We then create an instance of each class and call the `make_sound` method. Because each instance is of a different class, the method call results in a different sound being printed.

This is an example of polymorphism, which is the ability of different objects to respond to the same message (method call) in different ways.

## 4. Access Modifiers

In Ruby, you can control the visibility of attributes and methods using access modifiers. Access modifiers allow you to specify which parts of your code can access certain attributes and methods.

Here's an example:

```ruby
class Person
  attr_reader :name
  attr_accessor :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    puts "Hello, my name is #{@name}, and I'm #{@age} years old."
  end

  private

  def calculate_years_until_retirement
    65 - @age
  end
end

person = Person.new("John", 30)
puts person.name
person.age = 35
person.say_hello
```

In this example, we define a `Person` class with two attributes, `name` and `age`, and a `say_hello` method that prints a message with the person's name and age.

We use the `attr_reader` and `attr_accessor` methods to define getter and setter methods for the `name` and `age` attributes, respectively. We also define a `calculate_years_until_retirement` method that calculates the number of years until the person retires.

We mark the `calculate_years_until_retirement` method as private using the `private` keyword. This means that the method can only be called from within the class.

We then create an instance of the `Person` class and demonstrate how to use the getter and setter methods for the `name` and `age` attributes, as well as calling the `say_hello` method.

## Conclusion

In this guide, we covered the basics of object-oriented programming in Ruby. We learned about classes and objects, attributes and methods, inheritance and polymorphism, and access modifiers.

Object-oriented programming is a powerful paradigm that allows you to write code in terms of objects and their interactions. By understanding these concepts, you'll be able to create more robust and maintainable code in your Ruby projects.

In the next guide, we will dive deeper into some of the more advanced features of Ruby, including metaprogramming and functional programming. Stay tuned!
