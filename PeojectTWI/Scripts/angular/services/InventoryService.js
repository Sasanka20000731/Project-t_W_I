myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    $scope.PageLoad = function () {
        $http.get('/Inventory/GetProductCategoryValues')
        .success(function (response) {
            $scope.TypeChoices = response;
        }).error(function (xhr) {
            console.log(xhr.error);
        })

        //$http.get('/Inventory/GetmasterStoreValues')
        //.success(function (response) {
        //    $scope.TypeChoices2 = response;
        //}).error(function (xhr) {
        //    console.log(xhr.error);
        //})
    };

    $scope.SaveData = function () {
        debugger
        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                
                SerialNo: $scope.SerialNumber
            }
        };
        debugger;
        $http.get('/Inventory/ManageWareHouseData', data)
            .success(function (response) {
                debugger;
                $scope.popMessage(response);
            }).error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.popMessage = function (x) {
        debugger;
        if (x === true) {
            alertify.success("Operation completed successfully.");
        } else {
            alertify.error("An error occurred during the operation.");
        }
    }

    $scope.WHManageDataLoad = function () {
        data = {
            params: {
                FromDate: null,
                Todate: null
            }
        };
        $http.get('/Inventory/ViewWareHousedata', data)
        .success(function (response) {
            $scope.Result = response;
        })
        .error(function (xhr) {
            console.log(xhr.error);
        })
    };




});

