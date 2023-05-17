# Pagination Class in Ruby

G'day, mate! This README will walk you through the usage of the Pagination class that we've implemented in Ruby. We will also discuss how it can be used in a Ruby on Rails application.

## Getting Started

Our Pagination class is a small utility that is used to generate a range of page numbers for a pagination control. It takes three parameters:

* `current_page`: The current page number.
* `total_pages`: The total number of pages.
* `delta`: An optional parameter that represents the number of page numbers to display on either side of the current page (defaults to 2).

The class has a `call` method that calculates and returns an array of page numbers. If there are gaps between the pages, it inserts a '...' string to indicate the gap.

## Usage

To use the Pagination class, you would call the `call` method and pass in your parameters:

```ruby
pages = Pagination.call(current_page, total_pages)
```

This would return an array of page numbers and '...' strings.

For example:

```ruby
Pagination.call(5, 20)
# => [1, "...", 3, 4, 5, 6, 7, "...", 20]
```

To test this in your terminal, you can run the following command:

```bash
ruby pagination.rb
```

## Usage in Rails

In a Rails application, this Pagination class could be used as part of a view helper to generate a custom pagination control.

For example, you could have a helper method like this:

```ruby
def paginate(current_page, total_pages)
  pages = Pagination.call(current_page, total_pages)
  # Now generate HTML for the pagination control using the pages array.
end
```

Then in your view, you could call this helper method to generate the pagination control:

```erb
<%= paginate(@current_page, @total_pages) %>
```

## Why Use This in Rails?

Rails already has some great gems for pagination, like [Kaminari](https://github.com/kaminari/kaminari) and [will_paginate](https://github.com/mislav/will_paginate). But sometimes, you might need a custom solution - maybe you want to style your pagination control in a specific way, or maybe you need to handle pagination in a non-standard way.

In these cases, having a simple, clean Ruby class that you can easily customise can be a real lifesaver. It's also a good way to keep your code tidy and your logic easy to follow, which we all know is a fair dinkum good idea.

Remember, the Pagination class we've provided here is quite basic. It might not handle all edge cases and it might not have all the features you need. But it's a good starting point and it's easy to modify to suit your needs.

## Wrapping Up

That's about it for this quick tutorial. We hope it's been as fun for you to read as it was for us to write. If you've got any questions, don't hesitate to ask. Good onya, mate!
