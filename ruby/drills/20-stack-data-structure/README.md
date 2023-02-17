# Understanding the Stack Data Structure in Ruby

The stack data structure is a Last-In-First-Out (LIFO) data structure. This means that the last item added to the stack will be the first item removed from the stack. The stack data structure is often used to reverse the order of items. For example, if you have a stack of books, the last book you place on the stack will be the first book you take off the stack.

## Problem Statement

You want to implement a program that can maintain a set of data in a Last-In-First-Out (LIFO) manner using a stack data structure. You should be able to push items onto the stack, pop items off the stack, and determine the size of the stack.

## Instructions

1. Create a `Stack` class that initializes an empty stack array.
2. Implement a `push` method that adds items to the stack array.
3. Implement a `pop` method that removes and returns the last item added to the stack.
4. Implement a `size` method that returns the number of items in the stack.
5. Implement an `empty?` method that returns a boolean indicating whether the stack is empty or not.

## Example

```ruby
class Stack
  def initialize
    @stack = []
  end

  def push(item)
    @stack.push(item)
  end

  def pop
    @stack.pop
  end

  def size
    @stack.size
  end

  def empty?
    @stack.empty?
  end
end

stack = Stack.new
stack.push(1)
stack.push(2)
stack.push(3)

puts "Size of stack: #{stack.size}" # Size of stack: 3

puts "Popping items from stack:"
puts stack.pop # 3
puts stack.pop # 2
puts stack.pop # 1

puts "Size of stack: #{stack.size}" # Size of stack: 0

puts "Is stack empty? #{stack.empty?}" # Is stack empty? true
```

## Exercises

1. Implement a `peek` method that returns the last item added to the stack, but does not remove it from the stack.
2. Implement a `clear` method that removes all items from the stack.
3. Create a method that takes in a string as an argument and returns `true` if the string has a balanced set of parentheses, brackets, and braces (i.e., each opening character has a matching closing character in the correct order). For example, the string `"({})[]"` should return `true`, while the string `"([{])}"` should return `false`.

Here's an example solution to the exercises:

```ruby
class Stack
  def initialize
    @stack = []
  end
  
  def push(item)
    @stack.push(item)
  end
  
  def pop
    @stack.pop
  end
  
  def size
    @stack.size
  end
  
  def empty?
    @stack.empty?
  end
  
  def peek
    @stack.last
  end
  
  def clear
    @stack.clear
  end
  
  def balanced?(str)
    opening = "({["
    closing = ")}]"
    stack = Stack.new
    str.each_char do |char|
      if opening.include?(char)
        stack.push(char)
      elsif closing.include?(char)
        if stack.empty?
          return false
        elsif opening.index(stack.pop) != closing.index(char)
          return false
        end
      end
    end
    return stack.empty?
  end
end

stack = Stack.new
stack.push(1)
stack.push(2)
stack.push(3)

puts "Size of stack: #{stack.size}" # Size of stack: 3
puts "Last item added to stack: #{stack.peek}" # Last item added to stack: 3

stack.clear
puts "Is stack empty? #{stack.empty?}" # Is stack empty? true

puts "Is '({})[]' balanced? #{stack.balanced?('({})[]')}" # Is '({})[]' balanced? true
puts "Is '([{])}' balanced? #{stack.balanced?('([{])}')}" # Is '([{])}' balanced? false
```

The `peek` method returns the last item added to the stack without removing it, while the `clear` method removes all items from the stack. The `balanced?` method takes in a string and returns `true` if the string has a balanced set of parentheses, brackets, and braces, and `false` otherwise.
