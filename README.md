# Travel Calculator

This app helps estimate international long term travel costs. It helps cover build a good estimate of long term travel based on location, days abroad, and lvel of comfort, and daily spending level.

It is also being built just as a good excuse to learning new technologies.

# Getting started

	bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate db:test:prepare
    bundle exec rake


# Similar apps

http://www.independenttraveler.com/travel-budget-calculator

# TODO

* default values for trip
  * hotel, flight, visa, etc
*  default values for cost
  * estimate, quanity, etc 
* profile setup
  * home country
  * default currency  
* improved design and UX
* guest account creation flow (create a whole trip and calculations as a guest and then create account)
* Start building out Rspec tests
* preload countries and cities
* autofill cities on typing
* trip sharing (private, restricted, public)
* collaborators (trip editors) 

# Thanks for the help

This is a toy app for me to work on to learn some new technologies. So I am sure I will be cribbing info from various tutorials, open source, and books. I wanted to give a shout out to some resources that helped me along the way.

* [todo-rails4-angularjs](https://github.com/mkwiatkowski/todo-rails4-angularjs)