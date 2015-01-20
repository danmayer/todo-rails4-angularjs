angular.module('todoApp').factory 'Destination', ($resource, $http) ->
  class Destination
    constructor: (errorHandler) ->
      @service = $resource('/api/destinations/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'
      
    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((destination)-> 
        successHandler?(destination)
        destination), 
       @errorHandler)

