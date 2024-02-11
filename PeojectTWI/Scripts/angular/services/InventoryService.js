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

    $scope.CheckData = function () {
        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                SerialNo: $scope.SerialNumber
            }
        };

        $http.get('/Inventory/CheckExist', data)

            .success(function (response) {
             //   debugger
                if (response == "Already in the store") {
                    alertify.success('Already in the store', 3000);
                    $scope.disableSave = true;
                }
                else if (response == "Already not in the store") {
                    alertify.success('Already not in the store', 3000);
                    $scope.disableSave = true;

                } else {
                    $scope.disableSave = false;

                }

            }).error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.SaveData = function () {

        $scope.CheckData();

        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                SerialNo: $scope.SerialNumber
            }
        };
        $http.get('/Inventory/ManageWareHouseData', data)
            .success(function (response) {
                $scope.popMessage = response;
               // debugger;
                alertify.success($scope.popMessage, 3000);
                $scope.ClearWHManageForm();
            }).error(function (xhr) {
                console.log(xhr.error);
            })
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

    }

    $scope.ClearWHManageForm = function () {
        //debugger;
        $scope.RadioValue = undefined;
        $scope.SerialNumber = undefined;
       // $("#droproductCategory").val() =;
  
        $scope.droproductCategory = '';

    }

});

