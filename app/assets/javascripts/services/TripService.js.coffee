angular.module('todoApp').factory 'Trip', ($resource, $http) ->
  class Trip
    constructor: (errorHandler) ->
      @service = $resource('/api/trips/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @service(trip: attrs).$save ((trip) -> successHandler(trip)), @errorHandler      

    delete: (trip) ->
      new @service().$delete {id: trip.id}, (-> null), @errorHandler

    update: (trip, attrs) ->
      new @service(trip: attrs).$update {id: trip.id}, (-> null), @errorHandler
      
    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((trip)-> 
        successHandler?(trip)
        trip), 
       @errorHandler)

