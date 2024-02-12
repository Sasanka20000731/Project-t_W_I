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
            //data = {
            //    params: {
            //        SerialNumber: x
            //    }
            //};
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
        debugger;
        $http.get('/Ticket/AssignTicketToHandler',data)
            .success(function (response) {
                debugger
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


});