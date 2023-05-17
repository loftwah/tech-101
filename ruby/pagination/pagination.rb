# frozen_string_literal: true

class Pagination
    def self.call(current_page, total_pages, delta: 2)
      new(current_page, total_pages, delta: delta).call
    end
  
    def initialize(current_page, total_pages, delta: 2)
      @current_page = current_page
      @total_pages = total_pages
      @delta = delta
    end
  
    def call
      pages = (1..@total_pages).to_a
  
      left_range = @current_page - @delta
      right_range = @current_page + @delta + 1
  
      pages.select! do |page|
        page == 1 || page == @total_pages || (page >= left_range && page < right_range)
      end
  
      pages_with_dots = pages.each_cons(2).flat_map do |previous_page, page|
        gap = page - previous_page
  
        if gap == 2
          [previous_page + 1, page]
        elsif gap > 2
          ['...', page]
        else
          page
        end
      end
  
      # Ensure first page is always present
      pages_with_dots.unshift(pages.first) unless pages_with_dots.include?(pages.first)
  
      pages_with_dots
    end
  end
  
  # Test it:
  (1..20).each do |i|
    puts "Selected page #{i}: #{Pagination.call(i, 20).inspect}"
  end
  