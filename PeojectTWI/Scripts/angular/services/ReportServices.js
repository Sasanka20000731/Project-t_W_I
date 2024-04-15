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
                FromDate: $scope.UserReportFormDate,
                ToDate: $scope.UserReportToDate,
                ReportCategory: 1,
                ReportType: $("#droReportType").val()
            }
        };
        $http.get('/Report/SearchUserManagementReport', data)
            .success(function (response) {
                if (response && response.length !== 0) {
                    $scope.UserReport = response;
                } else {
                    alertify.error("No Records Available !!!", 3000);
                }

            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.LoadInventoryManagementReportData = function () {
        data = {
            params: {
                ReportCategory: 2
            }
        };
        $http.get('/Report/LoadReportDropDownData', data)
            .success(function (response) {
                $scope.droReportTypeList = response;
                debugger;
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.SearchInventoryManagementReportData = function () {
        debugger
        data = {
            params: {
                FromDate: $scope.InventoryReportFormDate,
                ToDate: $scope.InventoryReportToDate,
                ReportCategory: 2,
                ReportType: $("#droReportType").val()
            }
        };
        debugger
        $http.get('/Report/SearchInventoryManagementReport', data)
            .success(function (response) {
                if (response && response.length !== 0) {
                    $scope.InventoryReport = response;
                } else {
                    alertify.error("No Records Available !!!", 3000);
                }
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.LoadTicketManagementReportData = function () {
        data = {
            params: {
                ReportCategory: 3
            }
        };
        $http.get('/Report/LoadReportDropDownData', data)
            .success(function (response) {
                $scope.droReportTypeList = response;
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.SearchTicketManagementReportData = function () {
        data = {
            params: {
                FromDate: $scope.TicketReportFormDate,
                ToDate: $scope.TicketReportToDate,
                ReportCategory: 3,
                ReportType: $("#droReportType").val()
            }
        };
        $http.get('/Report/SearchTicketManagementReport', data)

            .success(function (response) {
                if (response && response.length !== 0) {
                    $scope.TiketReportlist = response;
                } else {
                    alertify.error("No Records Available !!!", 3000);
                }

            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.LoadWarrentyManagementReportData = function () {
        data = {
            params: {
                ReportCategory: 4
            }
        };
        $http.get('/Report/LoadReportDropDownData', data)
            .success(function (response) {
                $scope.droReportTypeList = response;
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })
    }

    $scope.SearchWarrentyManagementReportData = function () {
        data = {
            params: {
                FromDate: $scope.WarrentyReportFormDate,
                ToDate: $scope.WarrentyReportToDate,
                ReportCategory: 4,
                ReportType: $("#droReportType").val()
            }
        };
        $http.get('/Report/SearchWarrentyManagementReport', data)
            .success(function (response) {           
                if (response && response.length !== 0) {
                    $scope.WarrentyReportlist = response;
                } else {
                    alertify.error("No Records Available !!!", 3000);
                }
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

});