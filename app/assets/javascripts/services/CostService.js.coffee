angular.module('todoApp').factory 'Cost', ($resource, $http) ->
  class Cost
    constructor: (tripId, errorHandler) ->
      @service = $resource('/api/trips/:trip_id/costs/:id',
        {trip_id: tripId, id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(cost: attrs).$save ((cost) -> attrs.id = cost.id), @errorHandler
      attrs

    delete: (cost) ->
      new @service().$delete {id: cost.id}, (-> null), @errorHandler

    update: (cost, attrs) ->
      new @service(cost: attrs).$update {id: cost.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
