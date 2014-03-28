API_ENTRYPOINT = "https://api.github.com/"

app = angular.module('githubRankApp', ['ui.select2', 'ngCookies'])

app.controller 'SearchCtrl', ($scope, $http, $cookies) ->

  # Countries and Languages Lists
  $scope.countryList = [
    {name: 'China', value: 'China'},
    {name: 'Taiwan', value: 'Taiwan'},
    {name: 'Hong Kong', value: 'Hong Kong'},
    {name: 'Australia', value: 'Australia'}
  ]
  $scope.languageList = [
    {name: 'CSS', value: 'CSS'},
    {name: 'CoffeeScript', value: 'CoffeeScript'},
    {name: 'JavaScript', value: 'JavaScript'},
    {name: 'PHP', value: 'PHP'},
    {name: 'Ruby', value: 'Ruby'},
    {name: 'Shell', value: 'Shell'},
    {name: 'VimL', value: 'VimL'},
    {name: 'Python', value: 'Python'},
    {name: 'ASP', value: 'ASP'},
    {name: 'Objective-C', value: 'Objective-C'},
    {name: 'Perl', value: 'Perl'}
  ]

  # Selected values.
  $scope.users = []
  $scope.countries = $cookies.countries || 'Taiwan'
  $scope.languages = $cookies.languages || 'JavaScript'

  # Fetch user's profile data from github
  $scope.getUserProfile = (user, rank) ->
    $scope.profile = null
    url = "#{API_ENTRYPOINT}users/#{user.login}?callback=JSON_CALLBACK"
    $http.jsonp(url).then (response) ->
      $scope.profile = response.data.data
      $scope.profile.rank = rank

  # Handles profile hide event
  $scope.hide = ->
    $scope.profile = null

  # Handles keyup event
  $scope.keyup = (e) ->
    $scope.profile = null if e.keyCode == 27


  # Updates rank users
  $scope.updateUsers = ->
    $cookies.countries = $scope.countries
    $cookies.languages = $scope.languages
    queries = []
    queries.push("location:#{encodeURIComponent($scope.countries)}") if $scope.countries.length
    queries.push("language:#{$scope.languages}") if $scope.languages.length
    url = "#{API_ENTRYPOINT}search/users?q=#{queries.join('+')}&sort=followers&page=1&per_page=50&callback=JSON_CALLBACK"
    $http.jsonp(url).then (response) ->
      $scope.users = response.data.data.items
  $scope.updateUsers()

  return $scope

