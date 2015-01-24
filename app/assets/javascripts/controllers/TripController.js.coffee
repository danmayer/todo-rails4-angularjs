angular.module('todoApp').controller "TripController", ($scope, $timeout, $routeParams, $location, Cost, Trip, Destination) ->
  $scope.sortMethod = 'priority'
  $scope.sortableEnabled = true

  $scope.init = () ->
    @costService = new Cost($routeParams.trip_id, serverErrorHandler)
    @tripService = new Trip(serverErrorHandler)
    @destinationService = new Destination(serverErrorHandler)
    $scope.trip = @tripService.find $routeParams.trip_id, updateTotalEstimatedCost
    $scope.destinations = @destinationService.all()
    $scope.totalEstimatedCost = 0.00

  $scope.addCost = ->
    raisePriorities()
    cost = @costService.create(title: $scope.costTitle, estimate: $scope.costEstimate, trip_destinations_id: $scope.costTripDestinations)
    cost.priority = 1
    if cost.trip_destinations_id==null
      $scope.trip.unassociated_costs.unshift(cost)
    else
      $scope.trip.trip_destinations.filter( (el)->
        return parseInt(el.id)==parseInt(cost.trip_destinations_id)
      )[0].costs.unshift(cost)
    updateTotalEstimatedCost()
    $scope.costTitle = ""
    $scope.costEstimate = ""
    $scope.costTripDestinations = ""

  $scope.deleteCost = (cost) ->
    lowerPrioritiesBelow(cost)
    @costService.delete(cost)
    if cost.trip_destinations_id==null
      $scope.trip.unassociated_costs.splice($scope.trip.unassociated_costs.indexOf(cost), 1)
    else
      cost_collection = $scope.trip.trip_destinations.filter( (el)->
        return parseInt(el.id)==parseInt(cost.trip_destinations_id)
      )[0].costs
      cost_collection.splice(cost_collection.indexOf(cost), 1)
    updateTotalEstimatedCost()

  $scope.toggleCost = (cost) ->
    @costService.update(cost, paid: cost.paid)

  $scope.tripTitleEdited = (tripTitle) ->
    @tripService.update(@trip, title: tripTitle)

  $scope.tripDelete = ->
    result = confirm "Are you sure you want to remove this trip?"
    
    if result
      @tripService.delete(@trip)
      $location.url("/dashboard")
  
  $scope.costEdited = (cost) ->
    @costService.update(cost, title: cost.title, estimate: cost.estimate)
    updateTotalEstimatedCost()

  $scope.dueDatePicked = (task) ->
    @costService.update(task, due_date: task.due_date)

  $scope.priorityChanged = (cost) ->
    @costService.update(cost, target_priority: cost.priority)
    updatePriorities()

  $scope.sortableOptions =
    update: (e, ui) ->
      domIndexOf = (e) -> e.siblings().andSelf().index(e)
      newPriority = domIndexOf(ui.item) + 1

      cost = ui.item.scope().cost
      cost.priority = newPriority

      $scope.priorityChanged(cost)

  $scope.changeSortMethod = (sortMethod) ->
    $scope.sortMethod = sortMethod
    if sortMethod == 'priority'
      $scope.sortableEnabled = true
    else
      $scope.sortableEnabled = false

  $scope.dueDateNullLast = (task) ->
    task.due_date ? '2999-12-31'

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")

  updatePriorities = ->
    # During reordering it's simplest to just mirror priorities based on task
    # positions in the list.
    $timeout ->
      angular.forEach $scope.trip.costs, (cost, index) ->
        cost.priority = index + 1

  raisePriorities = ->
    angular.forEach $scope.trip.costs, (t) -> t.priority += 1

  lowerPrioritiesBelow = (cost) ->
    angular.forEach costsBelow(cost), (t) ->
      t.priority -= 1
      
  costsBelow = (cost) ->
    $scope.trip.costs.slice($scope.trip.costs.indexOf(cost), $scope.trip.costs.length)

  updateTotalEstimatedCost = ->
    if $scope.trip && $scope.trip.costs && $scope.trip.trip_destinations
      destination_costs = $scope.trip.trip_destinations.map(
        (el) ->
          el.costs
      )
      destination_costs = destination_costs.concat.apply([], destination_costs)
      all_costs = $scope.trip.unassociated_costs.concat(destination_costs)
      $scope.totalEstimatedCost = all_costs.map(
        (el)->
          parseInt(el.estimate)
      ).reduce(
        (pv, cv) ->
          pv + cv;
        , 0);
    else
      $scope.totalEstimatedCost = 0.00