myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {


    $scope.LoadUserManagementReportData = function () {
        data = {
            params: {
                ReportCategory: 1
            }
        };
        $http.get('/Report/LoadReportDropDownData',data)
            .success(function (response) {
                $scope.droReportTypeList = response;
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }



    $scope.SearchUserManagementReport = function () {

        data = {
            params: {
                FromDate: UserReportFormDate,
                ToDate: UserReportToDate,
                ReportCategory:1,
                ReportType: $("#droReportType").val()
            }
        };
        $http.get('/Report/SearchUserManagementReport', data)

            .success(function (response) {
                $scope.UserReport = response;

            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }




});