myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    $scope.PageLoad = function () {

        $http.get('/Home/GetProductCategoryValues')
            .success(function (response) {
                debugger;
                $scope.TypeChoices = response;

            }).error(function (xhr) {
                console.log(xhr.error);
            })


    };

    $scope.SaveData = function () {
        debugger
        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                MasterStore: $("#droMasterStore").val(),
                SerialNo: $scope.SerialNumber
              
            }
        };
        debugger;
        $http.get('/Home/ManageWareHouseData', data)
            .success(function (response) {
                $scope.Markup = response;
            }).error(function (xhr) {
                console.log(xhr.error);
            })
    }

});

