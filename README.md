# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. In example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```

# Biker Project
* The Biker CLI app is an application that stores information on bike (Bicycles) owners, bikes and trips. 
  The preliminary version of the application pulls from a CSV file.  Future versions will pull from 
  https://bikeindex.org/api/v3/manufacturers? (which is the same data used to seed db).

## Setup
  Clone repo - git clone git@github.com:jeff-flatiron-bootcamp/ruby-project-guidelines-seattle-web-030920.git

  Run - bundle install

  To create and populate the database run the migration then run the seed by the following:

    rake db:migrate

    ruby db/seeds.rb
  
  Run the application 
    ruby bin/run.rb

## Run Instructions
  Biker app is composed of different menus.  To move among menus enter 
  a selection from the corresponding menu

  To use a practice account use the first account in the db. 
            ********  Login  **********       
        Please enter your account name with no spaces.
        
        !back - previous menu
        ***************************       

        Account name:> qq

  Once a user is logged in they can:
    View/add bikes to their owned bike list
    View/add trips to their trip list
    Get a total distance of trips
  
  

** Standard Use Cases
* [X] As a user, I want to be able to create a biker account.
* [X] As a user, I want to be able to associate bikes to my biker account.
*     As a user, I want to be able to be able create trips with my bike.
* [X] As a user, I want to know how many trips I have taken.
* [X] As a user, I want to know total miles for all trips.
*     As a user, I want to know how many trips I have taken with a certain bike.
* [x] As a user, I want to know the bike stolen status for all my bikes.

## Table Relations
### Associations
  bikes>-biker

  bikes-< Trip >-biker

### Biker
  has_many :bikes

  has_many :trips

### Bike
  belongs_to :biker 

  belongs_to :manufacturer

  has_many :trips 

### Trip
  belongs_to :biker
  
  belongs_to :bike

### Manufacturer   
  has_many :bikes

** Stretch Goal Use Cases
* As a user, I want to associate a bike to a manufacturer 
(Bonus work - pull manufacturer info from https://bikeindex.org/api/v3/manufacturers? url 
* [X] optional use CSV file with seed data)

