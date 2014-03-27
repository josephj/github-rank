API_ENTRYPOINT = "https://api.github.com/"

app = angular.module('githubRankApp', ['ui.select2'])

app.controller 'SearchCtrl', ($scope, $http) ->
  # Countries and Languages Lists
  $scope.countryList = [
    {name: 'China', value: 'China'},
    {name: 'Taiwan', value: 'Taiwan'},
    {name: 'Hong Kong', value: 'Hong Kong'}
  ]
  $scope.languageList = [
    {name: 'PHP', value: 'PHP'},
    {name: 'Ruby', value: 'Ruby'},
    {name: 'Python', value: 'Python'},
    {name: 'JavaScript', value: 'JavaScript'},
    {name: '.NET', value: '.NET'},
    {name: 'Perl', value: 'Perl'}
  ]
  # Selected values.
  $scope.users = []
  $scope.countries = 'Taiwan'
  $scope.languages = 'JavaScript'
  # Updates rank users.
  $scope.updateUsers = ->
    query = "location:#{$scope.countries}+language:#{$scope.languages}"
    url = "#{API_ENTRYPOINT}search/users?q=#{query}&sort=followers&page=1&per_page=50&callback=JSON_CALLBACK"
    $http.jsonp(url).then (response) ->
      $scope.users = response.data.data.items
  $scope.updateUsers()

  return $scope

