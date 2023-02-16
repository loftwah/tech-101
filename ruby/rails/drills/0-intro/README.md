# Ruby on Rails Intro

Ruby on Rails is a popular web framework written in the Ruby programming language. It is designed to make building web applications easier by providing a set of conventions and tools to streamline the development process.

## Getting Started

To get started with Ruby on Rails, you will need to have Ruby and Rails installed on your machine. You can install both using [rbenv](https://github.com/rbenv/rbenv) and [ruby-build](https://github.com/rbenv/ruby-build). On macOS, you can use [Homebrew](https://brew.sh/) to install rbenv and ruby-build:

`brew install rbenv ruby-build`

Once you have Ruby and Rails installed, you can create a new Rails application using the following command:

`rails new myapp`

This will create a new Rails application in a directory called `myapp`. You can then run the application using the following command:

```bash
cd myapp
rails server
```

This will start the Rails server and you can view your application by visiting `http://localhost:3000` in your web browser.

## MVC Architecture

Rails follows the Model-View-Controller (MVC) architecture. This means that the application is divided into three main components:

* **Model**: This represents the data and the business logic of the application.
* **View**: This is responsible for rendering the user interface.
* **Controller**: This handles user requests, interacts with the Model and sends data to the View.

## Routing

Rails uses a routing system to map URLs to Controllers and their actions. You can define routes in the `config/routes.rb` file. Here is an example of a route:

`get 'students/:id', to: 'students#show'`

This maps the URL `students/:id` to the `show` action in the `students` Controller.

## Controllers

Controllers handle incoming requests from the user and send responses back to the user. They typically interact with the Model to retrieve or manipulate data. Here is an example of a Controller:

```ruby
class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end
end
```

This defines a `StudentsController` with two actions: `index` and `show`. The `index` action retrieves all the students from the database and stores them in an instance variable called `@students`. The `show` action retrieves a single student based on the `:id` parameter and stores it in an instance variable called `@student`.

## Views

Views are responsible for rendering the user interface. They are typically written in HTML and embedded Ruby (ERb). Here is an example of a view:

```ruby
<h1>Students</h1>

<ul>
  <% @students.each do |student| %>
    <li>
      <%= link_to student.name, student_path(student) %>
    </li>
  <% end %>
</ul>
```

This displays a list of students using an instance variable called `@students`. It uses the `link_to` helper method to generate a link to the `show` action for each student.

## Models

Models represent the data and the business logic of the application. They typically interact with the database to retrieve or manipulate data. Here is an example of a model:

```ruby
class Student < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
```

This defines a `Student` model with two fields: `name` and `email`. It also includes two validation rules to ensure that the `name` field is present and that the `email` field is present and unique.

## Database

Rails provides support for multiple databases, but the most common is PostgreSQL. You can configure your database settings in the `config/database.yml` file. Here is an example configuration for PostgreSQL:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV["DATABASE_USERNAME"] %>
  password: <%= ENV["DATABASE_PASSWORD"] %>
  host: <%= ENV["DATABASE_HOST"] %>

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test

production:
  <<: *default
  database: myapp_production
  username: myapp
  password: <%= ENV['MYAPP_DATABASE_PASSWORD'] %>
```

This configuration file defines three environments: `development`, `test`, and `production`. Each environment has its own database and database settings.

## Migrations

Rails uses migrations to manage database schema changes. You can create a new migration using the following command:

`rails generate migration AddTitleToStudents name:string email:string:index`

This generates a new migration that adds `name` and `email` fields to the `students` table. The `:index` option creates an index on the `email` field for faster database lookups. You can then run the migration using the following command:

`rails db:migrate`

This applies the migration to the database.

## Assets

Rails provides support for managing assets such as stylesheets, JavaScript files, and images. You can place your assets in the `app/assets` directory. For example, you can place a stylesheet in `app/assets/stylesheets/application.scss`. Rails will automatically compile and serve the assets when the application is run in development mode.

## Testing

Rails comes with built-in support for testing using the [RSpec](https://rspec.info/) testing framework. You can generate a new test using the following command:

`rails generate rspec:model Student`

This generates a new test file for the `Student` model. You can run the tests using the following command:

`bundle exec rspec`

## Deployment

Rails applications can be deployed to a variety of platforms, including [Heroku](https://www.heroku.com/), [Amazon Web Services (AWS)](https://aws.amazon.com/), and [DigitalOcean](https://www.digitalocean.com/). To deploy a Rails application, you typically need to:

1. Create a production database.
2. Configure your application to use the production database.
3. Create a web server configuration file.
4. Deploy your application to the server.

## Conclusion

Ruby on Rails is a powerful web framework that makes building web applications faster and easier. With its emphasis on convention over configuration and its support for MVC architecture, routing, controllers, views, models, and testing, Rails provides a solid foundation for building robust and scalable web applications.
