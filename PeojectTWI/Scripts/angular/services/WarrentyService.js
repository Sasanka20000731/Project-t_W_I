myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    //$scope.SerialNumber = null;
    //$scope.ContactNumber = null;

    $scope.SearchWarrentyList = function () {
        debugger
       // $scope.SearchWarrentyBySerial($scope.SerialNumber);
       // $scope.SearchWarrentyByContactNumber($scope.ContactNumber);

        if ($scope.SerialNumber === undefined) {
            $scope.SearchWarrentyByContactNumber($scope.ContactNumber);
        } else if ($scope.ContactNumber === undefined) {
            $scope.SearchWarrentyBySerial($scope.SerialNumber);
        } else {
            alertify.error('Error', 3000);
            console.log(xhr.error);
        }
    }

    $scope.SearchWarrentyByContactNumber = function (y) {
        data = {
            params: {
                ContactNumber: y
            }
        };
        debugger;
        $http.get('/Warrenty/GetWarrentyList', data)
            .success(function (response) {
                $scope.LoadedWarrentyDataList = response;
                $scope.ClearFormOne();
                debugger;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }


    $scope.SearchWarrentyBySerial = function (x) {
        data = {
            params: {
                SerialNumber: x
            }
        };
        debugger;
        $http.get('/Warrenty/GetWarrentyCommentList', data)
            .success(function (response) {
                $scope.SerialNumberToDisplay = x;
                $scope.WarrentyStartDateToDisplay = response[0].WarrentyStartDate;
                $scope.WarrentyExpiredDateToDisplay = response[0].WarrentyExpiredDate;
                $scope.LoadedWarrentyCommentsData = response;
                $scope.ClearFormOne();
                debugger;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.ClearFormOne = function () {
        debugger
        $scope.SerialNumber = undefined;
        $scope.ContactNumber = undefined;

    }

    $scope.Extend = function () {
        debugger
        data = {
            params: {
                SerialNumber: x
            }
        };
        $http.get('/Warrenty/ExtendWarrenty',data)
            .success(function (response) {

                debugger;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }


});