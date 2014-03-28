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
      }, {
        name: 'Australia',
        value: 'Australia'
      }
    ];
    $scope.languageList = [
      {
        name: 'CSS',
        value: 'CSS'
      }, {
        name: 'CoffeeScript',
        value: 'CoffeeScript'
      }, {
        name: 'JavaScript',
        value: 'JavaScript'
      }, {
        name: 'PHP',
        value: 'PHP'
      }, {
        name: 'Ruby',
        value: 'Ruby'
      }, {
        name: 'Shell',
        value: 'Shell'
      }, {
        name: 'VimL',
        value: 'VimL'
      }, {
        name: 'Python',
        value: 'Python'
      }, {
        name: 'ASP',
        value: 'ASP'
      }, {
        name: 'Objective-C',
        value: 'Objective-C'
      }, {
        name: 'Perl',
        value: 'Perl'
      }
    ];
    $scope.users = [];
    $scope.countries = $cookies.countries ? $cookies.countries.split(',') : ['Taiwan'];
    $scope.languages = $cookies.languages ? $cookies.languages.split(',') : ['JavaScript'];
    $scope.getUserProfile = function(user, rank) {
      var url;
      $scope.profile = null;
      url = "" + API_ENTRYPOINT + "users/" + user.login + "?callback=JSON_CALLBACK";
      return $http.jsonp(url).then(function(response) {
        $scope.profile = response.data.data;
        return $scope.profile.rank = rank;
      });
    };
    $scope.hide = function() {
      return $scope.profile = null;
    };
    $scope.keyup = function(e) {
      if (e.keyCode === 27) {
        return $scope.profile = null;
      }
    };
    $scope.updateUsers = function() {
      var queries, query, url;
      $cookies.countries = $scope.countries.join(',');
      $cookies.languages = $scope.languages.join(',');
      queries = [];
      angular.forEach($scope.countries, function(value, key) {
        return queries.push("location:" + value);
      });
      angular.forEach($scope.languages, function(value, key) {
        return queries.push("language:" + value);
      });
      query = queries.join('+');
      url = "" + API_ENTRYPOINT + "search/users?q=" + query + "&sort=followers&page=1&per_page=50&callback=JSON_CALLBACK";
      return $http.jsonp(url).then(function(response) {
        return $scope.users = response.data.data.items;
      });
    };
    $scope.updateUsers();
    return $scope;
  });

}).call(this);
