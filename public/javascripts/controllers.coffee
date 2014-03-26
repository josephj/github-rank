app = angular.module('githubRankApp', ['ui.select2'])
app.controller 'FilterCtrl', ($scope) ->
  $scope.countries = [
    {name: 'China', value: 'China'},
    {name: 'Taiwan', value: 'Taiwan'},
    {name: 'Hong Kong', value: 'Hong Kong'}
  ]
  $scope.languages = [
    {name: 'PHP', value: 'PHP'},
    {name: 'Ruby', value: 'Ruby'},
    {name: 'Python', value: 'Python'},
    {name: 'JavaScript', value: 'JavaScript'},
    {name: '.NET', value: '.NET'},
    {name: 'Perl', value: 'Perl'}
  ]
  return $scope


