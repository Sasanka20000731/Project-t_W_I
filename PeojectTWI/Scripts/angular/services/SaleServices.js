myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    $scope.LoadData = function () {
        debugger;
        $http.get('/Sale/getSaleData')
            .success(function (response) {
                //$scope.TypeChoices = response;
            }).error(function (xhr) {
                //console.log(xhr.error);
            })
    }




});