angular.module('todoApp').controller "DashboardController", ($scope, $routeParams, $location, TaskList, Trip) ->

  $scope.init = ->        
    @listsService = new TaskList(serverErrorHandler)
    $scope.lists = @listsService.all()
    @tripsService = new Trip(serverErrorHandler)
    $scope.trips = @tripsService.all()

  $scope.createList = (name) ->
    @listsService.create name: name, (list) ->
        $location.url("/task_lists/#{list.id}")

  $scope.deleteList = (list, index) ->
    result = confirm "Are you sure you want to remove this list?" 

    if result
      @listsService.delete list
      $scope.lists.splice index, 1
      
  $scope.createTrip = (title) ->
    @tripsService.create title: title, (trip) ->
        $location.url("/trips/#{trip.id}")

  $scope.deleteTrip = (trip, index) ->
    result = confirm "Are you sure you want to remove this trip?" 

    if result
      @tripsService.delete trip
      $scope.trips.splice index, 1

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")
