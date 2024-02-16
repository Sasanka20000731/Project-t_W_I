//const { data } = require("jquery");

myApp.controller("MyController", function ($scope, $http, $window, $uibModal, $uibModalStack, $rootScope) {

    // 8746GSFGGSWGSXH45
    $scope.AddTicket = function () {
        data = {
            params: {
                SerialNumber: $scope.SerialNumber,
                TicketRemark: $scope.ticketTemark
            }
        };
        debugger;
        $http.get('/Ticket/InsertTicket', data)
            .success(function (response) {
                if (response == 1) {
                    alertify.success('Ticket Successfully Created', 3000);
                } else {
                    alertify.error('Error', 5000);
                }
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.LoadTicketHandlers = function () {
        debugger;
        $http.get('/Ticket/GetTicketHandlers')
            .success(function (response) {
                debugger
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


});