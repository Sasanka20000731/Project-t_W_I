//const { data } = require("jquery");

myApp.controller("MyController", function ($scope, $http, $window, $uibModal, $uibModalStack, $rootScope) {

    $scope.validationMessage = true;
    // 8746GSFGGSWGSXH45
    $scope.AddTicket = function () {
        data = {
            params: {
                SerialNumber: $scope.SerialNumber,
                TicketRemark: $scope.ticketTemark
            }
        };
        //debugger;
        $http.get('/Ticket/InsertTicket', data)
            .success(function (response) {
                //debugger
                if (response == 1) {
                   
                    alertify.success('Ticket Successfully Created', 3000);
                    $scope.ClearTicketForm();
                } else {
                    alertify.error('Error', 5000);
                }
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.GetProductDetails = function () {
        data = {
            params: {
                SerialNo: $scope.SerialNumber
            }
        };
        $http.get('/Ticket/GetSerialDetailsToTicket', data)
            .success(function (response) {
               //debugger
                if (response.length > 0) {
                   $scope.HideValidation(1)
                } else {
                    $scope.HideValidation(2)
                }

            }).error(function (xhr) {
                console.log(xhr.error);

                alertify.success($scope.popMessage, 3000);
            })
    }

    $scope.HideValidation = function (x) {
        if (x == 1) {
            $scope.validationMessage = true;

        } else {
            $scope.validationMessage = false;

        }

    }

    $scope.ClearTicketForm = function()
    {

        $scope.SerialNumber = undefined;
        $scope.ticketTemark = undefined;
    }


    $scope.LoadTicketHandlers = function () {
       //debugger;
        $http.get('/Ticket/GetTicketHandlers')
            .success(function (response) {
                //debugger
                $scope.TicketHandlers = response;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.AssignTicket = function () {
        data = {
            params: {
                TicketId: $("#TicketId").val(),
                AssignToUsrer: $scope.DropTicketHandlersList
            }
        };
        $http.get('/Ticket/AssignTicketToHandler',data)
            .success(function (response) {
                if (response == 1) {
                    alertify.success('Successfully Assigned', 3000);
                } else {
                    alertify.error('Error', 5000);
                }
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.LogadPendingTickets = function () {
        $http.get('/Ticket/LogadPendingTickets')
            .success(function (response) {
                $scope.PendingTicketResult = response;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.getTicketDetailsPage = function (ticketID) {
        var extendUrl = '/Ticket/getTicketDetailsPage?ticketID=' + ticketID;
        window.location.href = extendUrl;
    }

    $scope.LoadTicketdetailsToManage = function () {
        data = {
            params: {
                TicketId: $("#TicketId").val()
            }
        };
        //debugger
        $http.get('/Ticket/LoadTicketdetailsToManage', data)
            .success(function (response) {

                $scope.TicketNumber = response[0].TicketId;
                $scope.TicketDescription = response[0].TicketDiscription;
                $scope.TicketDate = response[0].TicketDate;
                $scope.CurrentSequnceIndex = response[0].CurrentSequnceIndex;
                $scope.CurrentSequence = response[0].CurrentSequnce;
                $scope.AssignedFrom = response[0].AssignedFrom;
                $scope.SerialNumber = response[0].SerialNumber;
                $scope.TicketStatus = response[0].TicketStatus;
               // debugger
                $scope.TicketComment = response;
                $scope.SequenceData = response;
                $scope.nextUserList = response;

            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.ManageTicket = function (Status) {



        data = {
            params: {
                TicketId: $("#TicketId").val(),
                StatusID: Status,
                AssignTo: $scope.dropNextSubmitUsers
            }
        };

        $http.get('/Ticket/ManageTicketLevelToLevel', data)
            .success(function (response) {
                if (response == 2) {
                    alertify.success('Accepted', 3000);
                } else if (response == 3) {
                    alertify.success('Successfully Submitted', 3000);
                } else if (response == 4) {
                    alertify.success('Successfully Rejected', 3000);
                } else if (response == 5) {
                    alertify.success('Successfully Closed Ticket', 3000);
                }else {
                    alertify.error('Error', 5000);
                }

                $scope.LoadTicketdetailsToManage();
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }


    $scope.SearchTicketLists = function () {
        //debugger;
        data = {
            params: {
                TicketId: $scope.TicketNumber,
                customerContact: $scope.TicketCustomerContactNumber
            }
        };
        $http.get('/Ticket/SerchTickeList', data)
            .success(function (response) {

                $scope.SearchTicketList = response;
                $scope.TicketNumber = null;
                $scope.TicketCustomerContactNumber = null;
                $scope.$apply();
                debugger;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.getAllTicketDetails = function (ticketID) {

        var extendUrl = '/Ticket/getSearchTicketDetails?ticketID=' + ticketID;
        window.location.href = extendUrl;

    }



});