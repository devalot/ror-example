# Self-guided Ruby on Rails 3.1 Tutorial

This is a small application using Ruby on Rails 3.1 to demonstrate how
a new application might be bootstrapped and features added over time.
It's a self-guided tour, you should use this guide to follow along
with the commits and branches.  Even better, you should try to
replicate each step on your own using this application as a guide.

Make sure you open each referenced file in your text editor of choice.
As new features are introduced comments in the source code provide
guidance as to why they are being used.

This example application is brought to you by [Peter Jones] and
[Devalot].  For more information about this application please read
[this article] [article].

[Peter Jones]: https://twitter.com/#!/contextualdev
[Devalot]: http://www.devalot.com
[article]: http://www.devalot.com/articles/2011/11/ror-example

## What This Application Does

This is very simple application where you register your car and then
record basic information each time you go to the gas station and
refuel.  It then calculates some basic information like miles per
gallon (my apologies to the rest of the world that uses the much
preferred metric system).

## How to Use This Guide

Follow along with each step trying to recreate the changes in your own
application.  Use the features of git to help you see the changes in
each branch and for each file.  If you are not comfortable with git
you can use the browser interface on Github.

If you don't understand something Google is your friend.  You can also
open a ticket or post a comment on Github.

## Dependencies

Before you start you should have a working installation of [Ruby].
Versions 1.8.7 and 1.9.3 should both work.  You should also have
[SQLite3] installed.

[ruby]: http://www.ruby-lang.org/
[sqlite3]: http://www.sqlite.org/

## Using this Application Right Now

If you're going to jump right in and run the application as it is
right now, you can:

    git clone git://github.com/devalot/ror-example.git
    cd ror-example
    bundle install
    rake db:migrate
    rails server

## The Beginning: Creating the Application

1. Install the `rails` gem and create a new Ruby on Rails application.

        gem install rails
        rails new example
        cd example

    Feel free to use a name other than "example" for your application.

2. Remove some of the default files that we won't be using.

        rm app/assets/images/rails.png
        rm public/index.html
        rm public/favicon.ico

3. Edit the `Gemfile` to pick a JavaScript interpreter (I recommend
   [The Ruby Racer]) then update your `Gemfile.lock` file by running
   the `bundle` command.

        bundle install

4. Optionally create a new [Git] repository for this rails
   application.

        git init
        git add .
        git ci -m "Initial commit"

[git]: http://git-scm.com/
[the ruby racer]: https://github.com/cowboyd/therubyracer

## Add Users and Authentication Plumbing

The very first thing we'll want to do is create a model for users and
a database table for users.  We'll also need some basic authentication
code in place to store a user's password securely.

To see what the application looks like at the end of this section you
can use the [01-user-model] branch.  To see a diff for the changes in
this section use commit [1e32158].

1. Use the rails generator to create a user model.  A shortcut for
   `rails generate` is `rails g`.

        rails g model user

2. Well be using [FactoryGirl] instead of fixtures, so remove the
   fixture file that was created.  We could have also given the
   `--no-fixture` option to the generator to not generate the fixture
   in the first place.

        rm test/fixtures/users.yml

3. The model generator also created a database migration that needs to
   be edited so we can properly set up the users table in the
   database.

   Edit `db/migrate/20111102182704_create_users.rb` then:

        rake db:migrate

4. Add validation and authentication code by editing the following
   files.

   * `app/models/user.rb`
   * `test/unit/user_test.rb`

   Then run the tests.

        rake test

[01-user-model]: https://github.com/devalot/ror-example/tree/01-user-model
[1e32158]: https://github.com/devalot/ror-example/commit/1e32158254b0390907ab88064f5188c606f139ed
[factorygirl]: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md

## Add the Remaining Models: Car and Refuel

Next we're going to need models and database tables for cars and
refuels.

To see what the application looks like at the end of this section you
can use the [02-car-refuel] branch.  To see a diff for the changes in
this section use commit [8032839] (or diff against the previous
branch).

1. Create two more model files for cars and refuels.

        rails g model car --no-fixture
        rails g model refuel --no-fixture

2. Edit the migrations to set up the cars and refuels database tables.

   * `db/migrate/20111102192932_create_cars.rb`
   * `db/migrate/20111102210426_create_refuels.rb`

   Then migrate the database:

        rake db:migrate

3. Edit the `Gemfile` to add new dependencies: the `money` and
   `factory_girl_rails` gems.  Then use the `bundle` command to update
   the `Gemfile.lock` file.

        bundle install

4. Add the appropriate model associations and create the logic for
   calculating miles per gallon.  Edit the following files.

   * `app/models/user.rb`
   * `app/models/car.rb`
   * `app/models/refuel.rb`

   Create a file to hold the testing factories (a simple way to build
   model objects) and then add some testing logic for the calculations
   in the refuel model.  Edit the following files.

   * `test/factories.rb`
   * `test/unit/refuel_test.rb`

   Make sure all the tests are passing.

        rake test

[02-car-refuel]: https://github.com/devalot/ror-example/tree/02-car-refuel
[8032839]: https://github.com/devalot/ror-example/commit/8032839c25f0068c6a9756f7a0d333cf0a94d998

## Session Management (login, logout)

Now we can add the files necessary to play with the application in a
web browser.  We're going to add the ability to log in and log out of
the application.

To see what the application looks like at the end of this section you
can use the [03-sessions] branch.  To see a diff for the changes in
this section use commit [2ba4d36] (or diff against the previous
branch).

1. Generate two controllers.

        rails g controller cars
        rails g controller sessions

2. Remove files we don't need.

        rm app/assets/javascripts/cars.js.coffee
        rm app/assets/stylesheets/cars.css.scss
        rm app/assets/javascripts/sessions.js.coffee
        rm app/assets/stylesheets/sessions.css.scss

3. Add routes and authentication helpers by editing the following files.

   * `config/routes.rb`
   * `app/controllers/application_controller.rb`

4. Add session logic (login, logout) by editing the following files.

   * `app/controllers/sessions_controller.rb`
   * `app/views/sessions/new.html.erb`

5. Add minimum logic to the cars controller.

    Edit the following files:

    * `app/controllers/cars_controller.rb`
    * `app/views/cars/index.html.erb`

6. Test session management.

   Generate a new integration test:

        rails g integration_test login_flow

    Edit the following files:

    * `test/functional/sessions_controller_test.rb`
    * `test/integration/login_flow_test.rb`

    Then run the tests:

        rake test

7. Create a user record for yourself.

   Start the rails console and add a user record to the database.  The
   console allows you to interactively type in Ruby code:

        rails console

        User.create!(:first_name => 'John',
                     :last_name  => 'Doe',
                     :email      => 'john@doe.com',
                     :password   => 'foobar',
                     :password_confirmation => 'foobar')

8. Now see if you can log in, keeping in mind that you can't yet add a
   new car.  Start the rails server then open [http://localhost:3000]
   [localhost].

        rails server

[03-sessions]: https://github.com/devalot/ror-example/commits/03-sessions
[2ba4d36]: https://github.com/devalot/ror-example/commit/2ba4d369eff2126ea813e30dfc24ccb0113568df
[localhost]: http://localhost:3000

## Add the Ability to Create Cars and Refuels

Finally, we're going to add the ability to create cars and refuels in
the browser.

To see what the application looks like at the end of this section you
can use the [04-create-refuels] branch.  To see a diff for the changes
in this section use commit [da7d7de] (or diff against the previous
branch).

1. Add the controller logic and views to create and edit cars.

   Edit the following files:

   * `app/controllers/cars_controller.rb`
   * `app/views/cars/new.html.erb`
   * `app/views/cars/edit.html.erb`
   * `app/views/cars/index.html.erb`

2. Play with the new interface.

   Start the rails server:

        rails server

   Try the following URLs:

   * [http://localhost:3000/cars] [cars]
   * [http://localhost:3000/cars.xml] [xml]
   * [http://localhost:3000/cars.json] [json]

3. Create a controller and the interface for working with refuels.

   Create the controller:

        rails g controller refuels
        rm app/assets/javascripts/refuels.js.coffee
        rm app/assets/stylesheets/refuels.css.scss

   Edit the following files:

   * `config/routes.rb`
   * `app/controllers/refuels_controller.rb`
   * `app/views/refuels/index.html.erb`
   * `app/views/refuels/new.html.erb`
   * `app/views/refuels/_form.html.erb`
   * `app/views/refuels/edit.html.erb`
   * `app/views/refuels/show.html.erb`

4. Show information about the last refuel on the cars index.

   Add a `scope` to keep logic in the model.  Also add some methods to
   format the MPG attribute and calculate a cost per mile.  Edit the
   following file:

   * `app/models/refuel.rb`

   Add some additional details to the cars index to show MPG and cost
   per mile for the most recent refuel.  Edit the following file:

   * `app/views/cars/index.html.erb`

5. Improve the look and feel by adding some CSS and HTML changes.

   Edit the following files:

   * `app/views/layouts/application.html.erb`
   * `app/assets/stylesheets/basic.css.scss`
   * `app/assets/stylesheets/forms.css.scss`

6. Play with the application.

   Start the rails server and open [http://localhost:3000/] [cars].

[cars]: http://localhost:3000/cars
[xml]: http://localhost:3000/cars.xml
[json]: http://localhost:3000/cars.json
[04-create-refuels]: https://github.com/devalot/ror-example/commits/04-create-refuels
[da7d7de]: https://github.com/devalot/ror-example/commit/da7d7def6331d24a388802dbed0715dde737ef01

## Some Things to Consider

1. If you are creating a car or refuel record and omit a required
   field, the model validations will prevent the record from being
   saved to the database.  In prior versions of Rails a list of error
   messages would be shown above the form.

   That feature was removed in Rails 3 in order to make it easier to
   translate your application into multiple languages.  This means
   that you must generate your own user error messages.

   You can also install the [dynamic_form] plug-in to get these helper
   methods back into Rails 3 until you are ready to write them
   yourself.

2. Instead of implementing your own session management and
   authentication logic you may want to look at one of these plug-ins
   for Rails:

   * [Devise]
   * [Authlogic]

[dynamic_form]: https://github.com/rails/dynamic_form
[devise]: https://github.com/plataformatec/devise
[authlogic]: https://github.com/binarylogic/authlogic

## Exercises Left for the Reader

1. If you edit an existing refuel object and change the odometer or
   gallons attributes, the refuel object directly following the one
   you edited will have wrong values for distance and mpg.  Update the
   refuel model to recalculate these values when this happens.  Start
   by writing a test that fails.  This will also happen if you delete
   a refuel.

1. Write a `users` controller to allow a user to create an account.

2. Write a `passwords` controller to allow a user to change their
   password.  How would a user reset their password if they forgot
   it?

3. If a user enters the wrong password while logging in, set a
   `login_timeout` user attribute to `Time.now + 5.seconds` and don't
   let the user log in while `login_timeout` is in the future.  Each
   time the user tries to log in with the wrong password increase the
   number of seconds in the future the `login_timeout` is set for.
   Display the `login_timeout` in the login form so the user knows
   what's going on.  Tip: it may help to have a `failed_logins`
   counter in the users table.  Don't forget to reset it to 0 when the
   user successfully logs in.

4. Explore using Ajax to create cars and refuels so the user doesn't
   have to bounce around the application for each activity.
