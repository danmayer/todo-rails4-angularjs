# Travel Calculator

This app helps estimate international long term travel costs. It helps cover build a good estimate of long term travel based on location, days abroad, and lvel of comfort, and daily spending level.

It is also being built just as a good excuse to learning new
technologies.

[ ![Codeship Status for danmayer/travel_calculator](https://codeship.com/projects/a35ff250-97b7-0132-f770-6a66c6b56914/status?branch=master)](https://codeship.com/projects/63202)

# Getting started

	bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate db:test:prepare
    bundle exec rake
    
    rails s

# Similar apps

* [independent traveler calculator](http://www.independenttraveler.com/travel-budget-calculator)

# TODO
* make days a required trip_destinations field
*  default values for cost
  * estimate, quanity, etc
* default values for destination
  * hotel, flight, visa, food, big ticket items for coutries (Angkor passes)
* integrate into picoappz.com
* currency switcher in header
  * looking at money gem and money-rails
  * http://www.xe.com/?r=
  * http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  * https://github.com/RubyMoney/money
  * https://github.com/RubyMoney/money-rails
* improved design and UX (especially autocomplete box)
* guest account creation flow (create a whole trip and calculations as a guest and then create account)
* upgrade Rails
* upgrade Devise
* Start building out tests
* autocomplete countries (ES maybe) 
* later all airports and cities
  * http://ourairports.com/data/
  * http://datahub.io/dataset/open-flights
  * autocomplete cities in a country with [angular google places autocomplete](http://ngmodules.org/modules/ngAutocomplete), other advanced places options.
* autofill cities on typing
* trip sharing (private, restricted, public)
* collaborators (trip editors)
* swagger api docs
* fix page load flickering (ng-cloak not doing what I expect ask Angular club)

# Improvements

* [better mailchimp](http://designshack.net/articles/css/custom-mailchimp-email-signup-form/)

# Thanks for the help

This is a toy app for me to work on to learn some new technologies. So I am sure I will be cribbing info from various tutorials, open source, and books. I wanted to give a shout out to some resources that helped me along the way.

* [todo-rails4-angularjs](https://github.com/mkwiatkowski/todo-rails4-angularjs)
* [angucomplete-alt](https://github.com/ghiden/angucomplete-alt)
* [Android Login](http://lucatironi.github.io/tutorial/2012/10/15/ruby_rails_android_app_authentication_devise_tutorial_part_one/)
