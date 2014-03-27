(function() {
  var API_ENTRYPOINT, app;

  API_ENTRYPOINT = "https://api.github.com/";

  app = angular.module('githubRankApp', ['ui.select2', 'ngCookies']);

  app.controller('SearchCtrl', function($scope, $http, $cookies) {
    $scope.countryList = [
      {
        name: 'China',
        value: 'China'
      }, {
        name: 'Taiwan',
        value: 'Taiwan'
      }, {
        name: 'Hong Kong',
        value: 'Hong Kong'
      }
    ];
    $scope.languageList = [
      {
        name: 'PHP',
        value: 'PHP'
      }, {
        name: 'Ruby',
        value: 'Ruby'
      }, {
        name: 'Python',
        value: 'Python'
      }, {
        name: 'JavaScript',
        value: 'JavaScript'
      }, {
        name: '.NET',
        value: '.NET'
      }, {
        name: 'Perl',
        value: 'Perl'
      }
    ];
    $scope.users = [];
    $scope.countries = $cookies.countries || 'Taiwan';
    $scope.languages = $cookies.languages || 'JavaScript';
    $scope.updateUsers = function() {
      var query, url;
      $cookies.countries = $scope.countries;
      $cookies.languages = $scope.languages;
      query = "location:" + $scope.countries + "+language:" + $scope.languages;
      url = "" + API_ENTRYPOINT + "search/users?q=" + query + "&sort=followers&page=1&per_page=50&callback=JSON_CALLBACK";
      return $http.jsonp(url).then(function(response) {
        return $scope.users = response.data.data.items;
      });
    };
    $scope.updateUsers();
    return $scope;
  });

}).call(this);
