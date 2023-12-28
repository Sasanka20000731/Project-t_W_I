myApp.controller('myController', function ($scope, $http) {


    $scope.LoadGrid() = function (){
        debugger;
        $http.get('/Home/GetFillList')
            .success(function (response) {
                $scope.Data = response.list;
                $scope.FacilityCount = $scope.Data.length;
                $scope.FacilityAmount = response.amount;
                $scope.CurrentMonth = response.CurrentMonth;
                $scope.FirstDay = response.FirstDay;
                $scope.LastDay = response.LastDay;
            })
            .error(function (xhr, e) {
                console.log(xhr.error);
                $('.containerBlock').waitMe('hide');
                alertify.error("Invalid Operation.!", 3000);
            });
    }

});