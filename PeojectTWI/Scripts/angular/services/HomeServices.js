myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    $scope.CheckUserName = function () {
        data = {
            params: {
                UserName: $scope.UserName
            }
        };
        //debugger
        $http.get('/Home/VerifyUser', data)
            .success(function (response) {
                //debugger
                if (response === 0) {
                    $scope.InvalidUser = true;
                } else {

                    $scope.InvalidUser = false;
                }

            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.success("Error", 3000);
            })

    }

    $scope.login = function () {
        data = {
            params: {
                UserName: $scope.UserName,
                Password: $scope.Passowrd
            }
        };
        $http.get('/Home/loginUser', data)
            .success(function (response) {
               
                if (response === 1) {
   
                    $scope.LoadDashbord();

                } else {
                    $scope.InvalidUser = true;

                }

            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.success("Error", 3000);
            })

    }

    $scope.LoadDashbord = function ()
    {
 
        var extendUrl = '/Home/Index';
        window.location.href = extendUrl;
    }



});