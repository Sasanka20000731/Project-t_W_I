myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {

    $scope.mobileNumberAsyncError = false;

    $scope.CheckUserName = function () {
        data = {
            params: {
                UserName: $scope.UserName
            }
        };
        //debugger
        $http.get('/Home/VerifyUser', data)
            .success(function (response) {
                //debugger
                if (response === 0) {
                    $scope.InvalidUser = true;
                } else {

                    $scope.InvalidUser = false;
                }

            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.success("Error", 3000);
            })

    }

    $scope.login = function () {

        if (($scope.UserName != null && $scope.Passowrd != null) || ($scope.UserName != undefined && $scope.Passowrd != undefined)) {
            data = {
                params: {
                    UserName: $scope.UserName,
                    Password: $scope.Passowrd
                }
            };
            $http.get('/Home/loginUser', data)
                .success(function (response) {

                    if (response === 1) {

                        $scope.LoadDashbord();

                    } else {
                        $scope.InvalidUser = true;

                    }

                }).error(function (xhr) {
                    console.log(xhr.error);
                    alertify.success("Error", 3000);
                })

        } else {
            debugger
            alertify.success("Fill User Name and Password !!!", 3000);
        }
    }

    $scope.LoadDashbord = function () {

        var extendUrl = '/Home/Index';
        window.location.href = extendUrl;
    }

    $scope.LoadUserLevels = function () {
        //debugger
        $http.get('/Home/getUserLlevels')
            .success(function (response) {
                $scope.UserLevelList = response;
            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.success("error", 3000);
            })
    }

    $scope.validateMobileNumber = function () {
        if (($scope.MobileNumber && $scope.MobileNumber.length === 10 && /^\d+$/.test($scope.MobileNumber) && $scope.MobileNumber.startsWith('0')) || ($scope.MobileNumber === undefined) || ($scope.MobileNumber === "")) {
            $scope.mobileNumberAsyncError = false;
            $scope.mobileNumberAsyncErrorMessage = "";
        } else {

            $scope.mobileNumberAsyncError = true;
            $scope.mobileNumberAsyncErrorMessage = "Mobile number should be 10 digits and valid mobile number!!!";
        }

    };

    $scope.validateEmail = function () {
        $scope.Email
        //debugger;
        if (!$scope.Email || $scope.Email.trim() === "") {
            $scope.EmailAsyncError = true;
            $scope.EmailAsyncErrorMessage = "Enter Valid Email Address!!!";
        } else {
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

            if (emailPattern.test($scope.Email)) {
                $scope.EmailAsyncError = false;
                $scope.EmailAsyncErrorMessage = "";
            } else {
                $scope.EmailAsyncError = true;
                $scope.EmailAsyncErrorMessage = "Enter a Valid Email Address!!!";
            }
        }
    };

    $scope.SaveUser = function () {

        data = {
            params: {
                UserName: $scope.UserName,
                FirstName: $scope.FirstName,
                LastName: $scope.LastName,
                DOB: $scope.DOB,
                Email: $scope.Email,
                MobileNumber: $scope.MobileNumber,
                UserLevel: $("#droUserLevels").val()
            }
        };
       
        $http.get('/Home/saveUser', data)
            .success(function (response) {
               
                if (response == 1) {
                    alertify.success('User Successfully Inserted', 3000);
                    $scope.ClearForm();
                } else {
                    alertify.error('Error', 5000);
                }
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })


    }

    $scope.ClearForm = function () {

        $scope.UserName = undefined;
        $scope.FirstName = undefined;
        $scope.LastName = undefined;
        $scope.DOB = undefined;
        $scope.Email = undefined;
        $scope.MobileNumber = undefined;
        $scope.droUserLevels = '';

    }

    $scope.LoadUserDetails = function () {
        $scope.LoadUserLevels();
        data = {
            params: {
                UserId: $("#UserId").val()
            }
        };
        //debugger;
        $http.get('/Home/getselectedUserDetails', data)
            .success(function (response) {
                $scope.UserName = response[0].UserName;
                $scope.FirstName = response[0].FirstName;
                $scope.LastName = response[0].LastName;
                var timestamp = response[0].DOB.match(/\d+/)[0];

                // Create a new Date object using the timestamp
                $scope.DOB = new Date(parseInt(timestamp));
                $scope.Email = response[0].Email;
                $scope.MobileNumber = response[0].MobileNumber;
                $scope.droUserLevels = response[0].UserLevel;
                $scope.Active = response[0].Active;
                debugger
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.UpdateUser = function () {

        $scope.Active;
        if ($scope.Active == undefined) {
            $scope.Active = false;
        }

        data = {
            params: {
                UserId: $("#UserId").val(),
                UserName: $scope.UserName,
                FirstName: $scope.FirstName,
                LastName: $scope.LastName,
                DOB: $scope.DOB,
                Email: $scope.Email,
                MobileNumber: $scope.MobileNumber,
                UserLevel: $scope.droUserLevels,
                Active: $scope.Active//$scope.Active
            }
        };
        debugger;
        $http.get('/Home/updateUsers', data)
            .success(function (response) {
                if (response === 1) {
                    debugger;
                    window.location.href = "/Home/viewUser";
                } else {
                    alertify.error("Error", 3000);
                }
                debugger
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }

});