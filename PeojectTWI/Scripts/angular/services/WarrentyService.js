myApp.controller("MyController", function ($scope, $http, $window, $uibModal, $uibModalStack, $rootScope)  {

    $scope.extendWarranty = function(serialNo) {
        debugger;
        // Construct the URL for the WarrentyController/ExtendWarrenty action result
        var extendUrl = '/Warrenty/ExtendWarrenty?SerialNumber=' + serialNo;

        // Redirect to the URL
        window.location.href = extendUrl;
    }


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
        //$scope.SerialNumber = undefined;
        //$scope.ContactNumber = undefined;

    }



        //$scope.Extend = function () {
  
        //    debugger
        //    //data = {
        //    //    params: {
        //    //        SerialNumber: x
        //    //    }
        //    //};
        //    //$http.get('/Warrenty/ExtendWarrenty',data)
        //    //    .success(function (response) {

        //    //        debugger;
        //    //    })
        //    //    .error(function (xhr) {
        //    //        console.log(xhr.error);
        //    //    })

        //    modalInsatance = $uibModal.open({
        //        templateUrl: "/Warrenty/ExtendWarrenty",
        //        controller: "MyController",
        //        backdrop: "static",
        //        keyboard: false,
        //        id: "dvbusinessModal"
        //    });

        //}

        //$scope.RejectRow = function (value, ExpectedValue) {

        //    scope.GlobleExpectedValue = ExpectedValue;
        //    debugger;
        //    scope.GlobalId = value;
        //    modalInsatance = $uibModal.open({
        //        templateUrl: "/Home/CommadModal",
        //        controller: "secondController",
        //        backdrop: "static",
        //        keyboard: false,
        //        id: "dvbusinessModal"
        //    });

        //}

    $scope.WarrExtndCal = function (x) {
        $scope.ExtendPtice = 0;
        $scope.currentValue = 0;
        if (x === "1") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 10) * 12;
        } else if (x === "2") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 8) * 24;
        } else if (x === "3") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 6) * 36;
        }
        return $scope.ExtendPtice;
    }

    $scope.Save = function (x) {
     
        if (x === "1") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 10) * 12;
        } else if (x === "2") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 8) * 24;
        } else if (x === "3") {
            $scope.ExtendPtice = ($scope.currentValue / 100 * 6) * 36;
        }
        return $scope.ExtendPtice;
    }


    $scope.OpenCloseThis = function () {
     

    } 






});