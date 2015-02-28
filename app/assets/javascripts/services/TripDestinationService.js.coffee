angular.module('todoApp').factory 'TripDestination', ($resource, $http) ->
  class TripDestination
    constructor: (tripId, errorHandler) ->
      @service = $resource('/api/trips/:trip_id/trip_destinations/:id',
        {trip_id: tripId, id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs,successHandler) ->
      new @service(tripDestination: attrs).$save ((tripDestination) -> attrs.id = tripDestination.id), @errorHandler
      successHandler? successHandler : null
      attrs

    delete: (tripDestination) ->
      new @service().$delete {id: tripDestination.id}, (-> null), @errorHandler

    update: (tripDestination, attrs) ->
      new @service(tripDestination: attrs).$update {id: tripDestination.id}, (-> null), @errorHandler
      
    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((tripDestination)-> 
        successHandler?(tripDestination)
        tripDestination), 
       @errorHandler)
