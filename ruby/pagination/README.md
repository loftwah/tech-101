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

Rails has some top-notch gems (Ruby code packages) for pagination, like [Kaminari](https://github.com/kaminari/kaminari) and [will_paginate](https://github.com/mislav/will_paginate). But sometimes, you might need something a bit custom. Maybe you want your pagination to look a certain way, or maybe you've got a special case that the gems can't handle.

That's where our Pagination class comes in. It's a simple bit of Ruby that you can tweak to get just what you need. It also helps keep your code neat and your logic easy to understand. And if there's one thing we know, it's that clean code is happy code.

Now, our Pagination class is pretty basic. It might not cover all the weird cases, and it might not have all the features you're after. But it's a good place to start, and it's easy to change to fit your needs.

## Output

Here's what the output of the Pagination class looks like:

```bash
 ❯  ~/gits/tech-bootcamp/ruby/pagination   main±  ruby pagination.rb
Selected page 1: [1, 2, 3, "...", 20]
Selected page 2: [1, 2, 3, 4, "...", 20]
Selected page 3: [1, 2, 3, 4, 5, "...", 20]
Selected page 4: [1, 2, 3, 4, 5, 6, "...", 20]
Selected page 5: [1, 2, 3, 4, 5, 6, 7, "...", 20]
Selected page 6: [1, "...", 4, 5, 6, 7, 8, "...", 20]
Selected page 7: [1, "...", 5, 6, 7, 8, 9, "...", 20]
Selected page 8: [1, "...", 6, 7, 8, 9, 10, "...", 20]
Selected page 9: [1, "...", 7, 8, 9, 10, 11, "...", 20]
Selected page 10: [1, "...", 8, 9, 10, 11, 12, "...", 20]
Selected page 11: [1, "...", 9, 10, 11, 12, 13, "...", 20]
Selected page 12: [1, "...", 10, 11, 12, 13, 14, "...", 20]
Selected page 13: [1, "...", 11, 12, 13, 14, 15, "...", 20]
Selected page 14: [1, "...", 12, 13, 14, 15, 16, "...", 20]
Selected page 15: [1, "...", 13, 14, 15, 16, 17, "...", 20]
Selected page 16: [1, "...", 14, 15, 16, 17, 18, 19, 20]
Selected page 17: [1, "...", 15, 16, 17, 18, 19, 20]
Selected page 18: [1, "...", 16, 17, 18, 19, 20]
Selected page 19: [1, "...", 17, 18, 19, 20]
Selected page 20: [1, "...", 18, 19, 20]
```

What you're seeing is the output of the `pagination.rb` script when it's run. The script is generating a set of page numbers for a pagination control, for each page in a range from 1 to 20. The pagination control is designed to always show the first page, the last page, the current page, and two pages on either side of the current page (that's the default 'delta' of 2).

Let's break down the output:

1. `Selected page 1: [1, 2, 3, "...", 20]`

   Here, the current page is 1. So, the script shows page 1, then the next two pages (2 and 3), then a '...' to represent the pages it's skipping over, and finally the last page, 20.

2. `Selected page 2: [1, 2, 3, 4, "...", 20]`

   Now, the current page is 2. The script shows the first page, the current page (2), and the next two pages (3 and 4), then the '...' and the last page, 20.

3. `Selected page 5: [1, 2, 3, 4, 5, 6, 7, "...", 20]`

   Here, the current page is 5. The script shows the first page, the current page (5), and the next two pages (6 and 7). However, because 5 is only two pages away from the first page, the script also shows the pages leading up to the current page (2, 3, and 4).

4. `Selected page 6: [1, "...", 4, 5, 6, 7, 8, "...", 20]`

   Now things get a bit more interesting. The current page is 6, so the script shows the first page, the current page, and the next two pages (7 and 8). It also shows the two pages before the current page (4 and 5). Because there's now a gap between the first page and the pages around the current page, the script includes a '...' after the first page.

This pattern continues as the script generates the pagination control for each page in the range.

## Active Record

With Active Record in a Rails application, this Pagination class can be used to create a custom pagination control in conjunction with data pulled from a database using Active Record's querying capabilities.

For instance, consider you have a `Post` model and you want to display a list of posts with pagination. You could add a method to your controller to calculate the total number of pages based on the number of posts and the number of posts you want to display per page.

Here's an example:

```ruby
class PostsController < ApplicationController
  POSTS_PER_PAGE = 10

  def index
    @current_page = params[:page].to_i || 1
    @total_pages = (Post.count.to_f / POSTS_PER_PAGE).ceil

    @posts = Post.order(created_at: :desc).limit(POSTS_PER_PAGE).offset((@current_page - 1) * POSTS_PER_PAGE)
  end
end
```

In this controller, `@posts` would contain the posts for the current page, and `@current_page` and `@total_pages` would be used to generate the pagination control with the Pagination class.

You would call the `Pagination.call` method with `@current_page` and `@total_pages` in your view or in a view helper as I mentioned before, and generate the HTML for the pagination control based on the array of page numbers and "..." strings that `Pagination.call` returns.

> Note: `<%= paginate(@current_page, @total_pages) %>`

Please keep in mind that there are also gems like `will_paginate` and `kaminari` that can handle pagination for you in Rails applications. These gems provide ready-to-use, customizable pagination controls and integrate directly with Active Record, automatically handling the calculation of the number of pages and the retrieval of the records for the current page.

## Wrapping Up

That's about it for this quick tutorial. We hope it's been as fun for you to read as it was for us to write. If you've got any questions, don't hesitate to ask. Good onya, mate!
