API_ENTRYPOINT = "https://api.github.com/"

app = angular.module('githubRankApp', ['ui.select2', 'ngCookies'])

app.controller 'SearchCtrl', ($scope, $http, $cookies) ->
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
  $scope.countries = $cookies.countries || 'Taiwan'
  $scope.languages = $cookies.languages || 'JavaScript'
  # Updates rank users.
  $scope.updateUsers = () ->
    $cookies.countries = $scope.countries
    $cookies.languages = $scope.languages
    queries = []
    queries.push("location:#{$scope.countries}") if $scope.countries.length
    queries.push("language:#{$scope.languages}") if $scope.languages.length
    url = "#{API_ENTRYPOINT}search/users?q=#{queries.join('+')}&sort=followers&page=1&per_page=50&callback=JSON_CALLBACK"
    $http.jsonp(url).then (response) ->
      $scope.users = response.data.data.items
  $scope.updateUsers()

  return $scope

