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
                debugger;
                alertify.success($scope.popMessage, 3000);
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

});

