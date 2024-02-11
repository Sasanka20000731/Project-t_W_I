myApp.controller("MyController", function ($scope, $http, $window, $uibModal, $uibModalStack, $rootScope) {


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