# Travel Calculator

This app helps estimate international travel costs. It helps create a good estimate of long term travel costs based on country, days abroad, level of comfort, and daily spending level.

Really I built this as a good excuse to learning new
technologies. If you find any issues or have ideas for improvements, please submit a github issue.

[ ![Codeship Status for danmayer/travel_calculator](https://codeship.com/projects/a35ff250-97b7-0132-f770-6a66c6b56914/status?branch=master)](https://codeship.com/projects/63202)

# Getting started

	bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate db:test:prepare
    bundle exec rake
    
    bundle exec rake db:seed
    rails s

# Similar apps

* [independent traveler calculator](http://www.independenttraveler.com/travel-budget-calculator)

# TODO

* costs sort order
* destinations sorted by arrival date
* flights from home country to first location
* flights from last location to home country
* rethink flights source URL as they are priced as round trip opposed to moving forward (all 1 way?)
* dynamic hotel data
* click for view / edit detailed notes (cost or trip destination)
* Setting home country needs to use the auto-complete and match the country codes.
* 
* add calendar to countries arrival / departure
  * quick edit arrival and duration fields 
* make days a required trip_destinations field (api)
* ways to verify or capture places where airport codes are missing
* ways to erify or capture where visa infomation doesn't match up
* google chart breakdown of costs
* row breakdown estimated cost by country.
* Visa pricing: https://www.visahq.com/citizens/United-States/
* Angular Club or Brody help
  * fix page load flickering (ng-cloak not doing what I expect)
  * flicker on reloading trip
  * why can't I get cost.total to work opposed to costTotal(cost)
* default values for destination
  * dynamic hotel, flight, visa, food, big ticket items for coutries (Angkor passes)
* integrate into picoappz.com
* guest account creation flow (create a whole trip and calculations as a guest and then create account)
* for data always have a source. So you can link to the page I pulled the visa cost or flight or whatever.
* currency switcher in header
  * looking at money gem and money-rails
  * http://www.xe.com/?r=
  * http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  * https://github.com/RubyMoney/money
  * https://github.com/RubyMoney/money-rails
* upgrade Rails
* upgrade Devise
* Start building out tests
* kayak affliate
* Visa application affiliate	
* later all airports and cities
  * http://ourairports.com/data/
  * http://datahub.io/dataset/open-flights
  * autocomplete cities in a country with [angular google places autocomplete](http://ngmodules.org/modules/ngAutocomplete), other advanced places options.
* trip sharing (private, restricted, public)
* collaborators (trip editors)
* swagger api docs

# Refactoring

* countries are rendered into js, that should be a remote json call. Currently the assets cache
* move more out of controller to angular Directives and services

# Improvements

* [better mailchimp](http://designshack.net/articles/css/custom-mailchimp-email-signup-form/)

# Ideas

* [perhaps itegrate open_calais for location info](https://github.com/elguapo1611/open_calais)

# Thanks for the help

This is a toy app for me to work on to learn some new technologies. So I am sure I will be cribbing info from various tutorials, open source, and books. I wanted to give a shout out to some resources that helped me along the way.

* [todo-rails4-angularjs](https://github.com/mkwiatkowski/todo-rails4-angularjs)
* [angucomplete-alt](https://github.com/ghiden/angucomplete-alt)
* [Android Login](http://lucatironi.github.io/tutorial/2012/10/15/ruby_rails_android_app_authentication_devise_tutorial_part_one/)
* Thanks to Edie Rothman for thelp understanding Angular promises
