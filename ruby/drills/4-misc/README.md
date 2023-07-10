# Ruby Misc Drills

Doing some drills.

## **Write Code that Looks Like Ruby:**

Here's a simple class that represents a Kangaroo:

```ruby
class Kangaroo
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def hop
    puts "#{@name} is hopping!"
  end
end
```

This class has two instance variables (`@name` and `@age`), and one method (`hop`). The indentation is two spaces, which is the standard for Ruby.

## **Comments:**

Here's how you might add comments to this class:

```ruby
# Kangaroo class representing a kangaroo animal. Each kangaroo has a name and an age.
class Kangaroo
  # Initialize a new Kangaroo with a given name and age.
  def initialize(name, age)
    @name = name
    @age = age
  end

  # Make the kangaroo hop.
  def hop
    puts "#{@name} is hopping!"
  end
end
```

## **Ruby Rules and Conventions:**

The class above already follows the Ruby rules and conventions as described in your text. It uses snake\_case for method names and instance variables, and CamelCase for the class name. The methods have clear and concise names that indicate their function.

## **Control Statements and Code Blocks:**

Here, we can add an `if` control statement to the `hop` method, so that the kangaroo can only hop if it's not too old:

```ruby
# Make the kangaroo hop if it's not too old.
def hop
  if @age <= 10
    puts "#{@name} is hopping!"
  else
    puts "#{@name} is too old to hop."
  end
end
```

## **Ruby Collections:**

Now let's create an array of kangaroos:

```ruby
kangaroos = [
  Kangaroo.new("Skippy", 5),
  Kangaroo.new("Hoppy", 7),
  Kangaroo.new("Jumpie", 12)
]

kangaroos.each {|kangaroo| kangaroo.hop}
```

## **Strings vs Symbols:**

We can add a method that takes a symbol or a string as an argument, to display what the kangaroo is eating:

```ruby
def eat(food)
  puts "#{@name} is eating #{food.to_s}."
end
```

## **Duck Typing:**

Here's how we might add another animal class (Koala), and a method that can work with any animal that has a `speak` method:

```ruby
class Koala
  def initialize(name)
    @name = name
  end

  def speak
    puts "#{@name} says, 'Eucalyptus!'"
  end
end

def make_animal_speak(animal)
  animal.speak
end

kangaroo = Kangaroo.new("Skippy", 5)
koala = Koala.new("Cuddly")

make_animal_speak(kangaroo) # "Skippy is hopping!"
make_animal_speak(koala) # "Cuddly says, 'Eucalyptus!'"
```

## **Tests:**

Let's say we're using RSpec for testing. Here are some tests for our Kangaroo and Koala classes:

```ruby
require 'rspec'
require_relative 'kangaroo'
require_relative 'koala'

describe Kangaroo do
  let(:kangaroo) { Kangaroo.new("Skippy", 5) }

  it 'hops correctly' do
    expect(kangaroo.hop).to eq("Skippy is hopping!")
  end

  it 'eats correctly' do
    expect(kangaroo.eat(:grass)).to eq("Skippy is eating grass.")
  end
end

describe Koala do
  let(:koala) { Koala.new("Cuddly") }

  it 'speaks correctly' do
    expect(koala.speak).to eq("Cuddly says, 'Eucalyptus!'")
  end
end
```

## **Composed Method:**

Here, we could refactor the `hop` method to make it clearer:

```ruby
def hop
  if too_old_to_hop?
    puts "#{@name} is too old to hop."
  else
    perform_hop
  end
end

private

def too_old_to_hop?
  @age > 10
end

def perform_hop
  puts "#{@name} is hopping!"
end
```

## **Classes and Overloading:**

Let's add a `size` attribute to the Kangaroo class and overload the `>` operator:

```ruby
class Kangaroo
  attr_reader :size

  def initialize(name, age, size)
    @name = name
    @age = age
    @size = size
  end

  def >(other_kangaroo)
    self.size > other_kangaroo.size
  end
end
```

## **Ruby Modules:**

Here's a module for common mammal behaviors, which we can include in our classes:

```ruby
module Mammal
  def is_mammal?
    true
  end
end

class Kangaroo
  include Mammal
end

class Koala
  include Mammal
end
```

## **Metaprogramming:**

Here's how we might add a new method to the Kangaroo class at runtime:

```ruby
class Kangaroo
  def self.add_jump_method
    define_method(:jump) do
      puts "#{@name} is jumping!"
    end
  end
end

Kangaroo.add_jump_method
kangaroo = Kangaroo.new("Skippy", 5, 80)
kangaroo.jump
```

This code adds a `jump` method to the Kangaroo class. The new method is available to all instances of the Kangaroo class.
