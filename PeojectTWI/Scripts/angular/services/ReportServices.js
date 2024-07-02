﻿

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

        if (($scope.UserReportFormDate != null && $scope.UserReportToDate != null && $scope.droReportType != null) || ($scope.UserReportFormDate != undefined && $scope.UserReportToDate != undefined && $scope.droReportType != undefined)) {

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

        } else {

            alertify.error("Please Fill All Required Feilds !!!", 3000);
        }
       

    }

    $scope.DownloadUserManagementReport = function () {
        var fromDate = $scope.UserReportFormDate;
        var toDate = $scope.UserReportToDate;
        var reportType = $("#droReportType").val();
        //debugger
        var url = '/Report/DownloadUserManagementReport?FromDate=' + fromDate.toISOString() + '&ToDate=' + toDate.toISOString() + '&ReportCategory=1&ReportType=' + reportType;

        window.open(url, '_blank');
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
          
            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.SearchInventoryManagementReportData = function () {
        //debugger
        if (($scope.InventoryReportFormDate != null && $scope.InventoryReportToDate != null && $scope.droReportType != null) || ($scope.InventoryReportFormDate != undefined && $scope.InventoryReportToDate != undefined && $scope.droReportType != undefined)) {
            data = {
                params: {
                    FromDate: $scope.InventoryReportFormDate,
                    ToDate: $scope.InventoryReportToDate,
                    ReportCategory: 2,
                    ReportType: $("#droReportType").val()
                }
            };
            //debugger
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


        } else {
            alertify.error("Please Fill All Required Feilds !!!", 3000);

        }
        

    }

    $scope.DownloadInventoryManagementReport = function () {
        //debugger
        var fromDate = $scope.InventoryReportFormDate;
        var toDate = $scope.InventoryReportToDate;
        var reportType = $("#droReportType").val();
        //debugger
        var url = '/Report/DownloadInventoryManagementReport?FromDate=' + fromDate.toISOString() + '&ToDate=' + toDate.toISOString() + '&ReportCategory=2&ReportType=' + reportType;

        window.open(url, '_blank');
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

        if (($scope.TicketReportFormDate != null && $scope.TicketReportToDate != null && $scope.droReportType != null) || ($scope.TicketReportFormDate != undefined && $scope.TicketReportToDate != undefined && $scope.droReportType != undefined)) {
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
        } else {
            alertify.error("Please Fill All Required Feilds !!!", 3000);
        }
        

    }

    
    $scope.DownloadTicketManagementReport = function () {
        //debugger
        var fromDate = $scope.TicketReportFormDate;
        var toDate = $scope.TicketReportToDate;
        var reportType = $("#droReportType").val();
        //debugger
        var url = '/Report/DownloadTicketManagementReport?FromDate=' + fromDate.toISOString() + '&ToDate=' + toDate.toISOString() + '&ReportCategory=3&ReportType=' + reportType;

        window.open(url, '_blank');
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

        if (($scope.WarrentyReportFormDate != null && $scope.WarrentyReportToDate != null && $scope.droReportType != null) || ($scope.WarrentyReportFormDate != undefined && $scope.WarrentyReportToDate != undefined && $scope.droReportType != undefined)) {
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

        } else {
            alertify.error("Please Fill All Required Feilds !!!", 3000);
        }

        

    }


    
    $scope.DewonloadWarrentyManagementReport = function () {
        //debugger
        var fromDate = $scope.WarrentyReportFormDate;
        var toDate = $scope.WarrentyReportToDate;
        var reportType = $("#droReportType").val();
        //debugger
        var url = '/Report/DownloadWarrentyManagementReport?FromDate=' + fromDate.toISOString() + '&ToDate=' + toDate.toISOString() + '&ReportCategory=4&ReportType=' + reportType;

        window.open(url, '_blank');
    }


    $scope.LoadAuditTrialdata = function () {

        $http.get('/Report/LoadAuditTrialTypes')
            .success(function (response) {
              
                $scope.dropAudiTrialList = response;
                $scope.showReportTable = false;

            }).error(function (xhr) {
                alertify.error("Error", 3000);
                console.log(xhr.error);
            })

    }

    $scope.SearchAuditTrialData = function () {
       
        if (($scope.AuditTrialReportFormDate != null && $scope.AuditTrialReportToDate != null && $scope.droAuditTrialType != null)
            || ($scope.AuditTrialReportFormDate != undefined && $scope.AuditTrialReportToDate != undefined && $scope.droAuditTrialType != undefined)) {
            data = {
                params: {
                    FromDate: $scope.AuditTrialReportFormDate,
                    ToDate: $scope.AuditTrialReportToDate,
                    ReportType: $("#droReportType").val()
                }
            };

            $http.get('/Report/SearchAuditTrialReport', data)
                .success(function (response) {
                    if (response && response.length !== 0) {
                        $scope.AuditTrialtlist = response;
                        $scope.showReportTable = true;
                    } else {
                        alertify.error("No Records Available !!!", 3000);
                    }
                }).error(function (xhr) {
                    alertify.error("Error", 3000);
                    console.log(xhr.error);
                })

        } else {
            alertify.error("Please Fill All Required Feilds !!!", 3000);
        }

    }


    $scope.DownloadAudiTrialData = function () {

        var FromDate= $scope.AuditTrialReportFormDate;
        var ToDate= $scope.AuditTrialReportToDate;
        var ReportType= $("#droReportType").val();
        //debugger
        var url = '/Report/DownloadAuditTrialReport?FromDate=' + FromDate.toISOString() + '&ToDate=' + ToDate.toISOString() + '&ReportType=' + ReportType;

        window.open(url, '_blank');
        
    }

});