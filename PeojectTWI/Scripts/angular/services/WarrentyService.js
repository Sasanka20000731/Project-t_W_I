myApp.controller("MyController", function ($scope, $http, $window, $uibModal, $uibModalStack, $rootScope)  {



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
         
        $http.get('/Warrenty/GetWarrentyList', data)
            .success(function (response) {
                $scope.LoadedWarrentyDataList = response;
                $scope.ClearFormOne();
                 
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
         
        $http.get('/Warrenty/GetWarrentyCommentList', data)
            .success(function (response) {
                $scope.SerialNumberToDisplay = x;
                $scope.WarrentyStartDateToDisplay = response[0].WarrentyStartDate;
                $scope.WarrentyExpiredDateToDisplay = response[0].WarrentyExpiredDate;
                $scope.LoadedWarrentyCommentsData = response;
                $scope.SoldPrice = response[0].SoldPrice;
                $scope.ClearFormOne();
                 
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

    $scope.WarrExtndCal = function (x) {
        $scope.ExtendPrice = 0;
        debugger
        if (x === 1) {
            $scope.ExtendPrice = ($scope.SoldPrice / 100 * 2) ;
        } else if (x === 2) {
            $scope.ExtendPrice = ($scope.SoldPrice / 100 * 4) ;
        } else if (x === 3) {
            $scope.ExtendPrice = ($scope.SoldPrice / 100 * 5) ;
        }
        return $scope.ExtendPtice;
    }



    //$scope.Save = function (x) {
     
    //    if (x === "1") {
    //        $scope.ExtendPrice = ($scope.SoldPrice / 100 * 10) * 12;
    //    } else if (x === "2") {
    //        $scope.ExtendPrice = ($scope.SoldPrice / 100 * 8) * 24;
    //    } else if (x === "3") {
    //        $scope.ExtendPrice = ($scope.SoldPrice / 100 * 6) * 36;
    //    }
    //    return $scope.ExtendPtice;
    //}


    $scope.PageLoad = function () {
         
        $scope.SearchWarrentyBySerial($("#serialNumberId").val())
        

    } 

    $scope.extendWarranty = function (serialNo) {
         
        var extendUrl = '/Warrenty/ExtendWarrenty?SerialNumber=' + serialNo;
        window.location.href = extendUrl;
    }

    $scope.SaveExtendWarrenty = function ()
    {
        data = {
            params: {
                SerialNumber: $scope.SerialNumberToDisplay,
                ExtendCost: $scope.ExtendPrice
            }
        };
        debugger;
        $http.get('/Warrenty/SaveExtenWarrenty', data)
            .success(function (response) {
                $scope.LoadedWarrentyDataList = response;
                $scope.ClearFormOne();

            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }



});