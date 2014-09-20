class Router
  constructor: (@routeProvider, @locationProvider) ->
    @routeProvider.
      when "/",
        templateUrl: "/game_templates",
        controller: "GameCtrl"

    @locationProvider.html5Mode(true)

GameRouter = angular.module("GameRouter", [
  "ngRoute"
  ])

GameRouter.config(["$routeProvider", "$locationProvider", Router])



# Define Config for CSRF token (security)
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]





# OLD CODE
# GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
#   $routeProvider
#     .when "/",
#       templateUrl: "/game_templates",
#       controller: "GameCtrl"
#   # .when "/dialogs/",
#   #   templateUrl: "whatsyoursecret.html",
#   #   controller: "whatsYourSecretCtrl"
#   .otherwise
#     redirectTo: "/"

#   $locationProvider.html5Mode(true)
# ]
