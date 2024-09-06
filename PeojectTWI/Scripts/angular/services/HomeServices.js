﻿myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {

    $scope.mobileNumberAsyncError = false;

    $scope.LoadDashbordData = function () {

        $http.get('/Home/loadDashbordDetails')
            .success(function (response) {
                $scope.PendingTickets = response[0].PendingTickets;
                $scope.OpenedTickets = response[0].OpenedTickets;
                $scope.ClosedTickets = response[0].ClosedTickets;
                $scope.CurrentDate = response[0].CurrentDate;
            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.success("error", 3000);
            })

        $scope.LoadDashbordChartData();
        $scope.fetchData();
    }

    $scope.CheckUserName = function () {
        data = {
            params: {
                UserName: $scope.UserName
            }
        };
        $http.get('/Home/VerifyUser', data)
            .success(function (response) {
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
            alertify.success("Fill User Name and Password !!!", 3000);
        }
    }

    $scope.LoadDashbord = function () {

        var extendUrl = '/Home/Index';
        window.location.href = extendUrl;
    }

    $scope.forgetPassword = function () {
        var extendUrl = '/Home/ForgetPasswordPage';
        window.location.href = extendUrl;
    }

    $scope.LoadUserLevels = function () {
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
        //debugger
        if (
            ($scope.UserName != null || $scope.UserName != undefined) && ($scope.FirstName != null || $scope.FirstName != undefined)
            && ($scope.LastName != null || $scope.LastName != undefined) && ($scope.DOB != null || $scope.DOB != undefined)
            && ($scope.Email != null || $scope.Email != undefined) && ($scope.MobileNumber != null || $scope.MobileNumber != undefined)
            && ($("#droUserLevels").val() != null || $("#droUserLevels").val() != undefined)
        ) {
            debugger
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


        } else {
            alertify.error('Please fill all data in form', 5000);
        }

        

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

            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.UpdateUser = function () {
        debugger
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
                Active: $scope.Active
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

    $scope.loadUserProfile = function () {
        //loadUserProfileDetails
        $scope.ShowForm = false;
        $scope.FirstNameTxtBox = undefined;
        $scope.LastNameTxtBox = undefined;
        $http.get('/Home/loadUserProfileDetails')
            .success(function (response) {
                $scope.UserName = response[0].UserName;
                $scope.FullName = response[0].FirstName + ' ' + response[0].LastName;
                $scope.UserLevelString = response[0].UserLevelString;
                $scope.MobileNumber = response[0].MobileNumber;
                $scope.Email = response[0].Email;
                $scope.DOB = response[0].stringDOB;
                $scope.Password = response[0].Password;

            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.ViewUserUpdateForm = function () {
        $scope.ShowForm = true;
    }

    $scope.UpdateUserProfile = function () {

        debugger
        if ($scope.FirstNameTxtBox != undefined && $scope.LastNameTxtBox != undefined) {
            data = {
                params: {
                    FirstName: $scope.FirstNameTxtBox,
                    LastName: $scope.LastNameTxtBox
                }
            };
            debugger;
            $http.get('/Home/UpdateUserProfile', data)
                .success(function (response) {
                    if (response === 1) {
                        debugger;
                        alertify.success("Successfully Updated", 3000);
                        $scope.loadUserProfile();
                    } else {
                        alertify.error("Error", 3000);
                    }

                })
                .error(function (xhr) {
                    console.log(xhr.error);
                })
        } else {
            alertify.error("Fill all form", 3000);
        }

    }

    $scope.LoadDashbordChartData = function () {
        $scope.chartLoading = true; // Show loading animation
        $http.get('/Home/loadDashbordChart')
            .then(function (response) {
                var data = response.data;

                // Extracting data for the chart
                var ticketCounts = data.map(function (item) {
                    return item.TicketCount;
                });
                var ticketDates = data.map(function (item) {
                    return item.TicketDate;
                });

                var ctx = document.getElementById('myAreaChart').getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ticketDates,
                        datasets: [{
                            label: 'Ticket Count',
                            data: ticketCounts,
                            backgroundColor: 'rgba(78, 115, 223, 0.05)',
                            borderColor: 'rgba(78, 115, 223, 1)',
                            borderWidth: 1,

                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        scales: {
                            xAxes: [{
                                type: 'time',
                                time: {
                                    unit: 'day'
                                },
                                distribution: 'series',
                                ticks: {
                                    source: 'data'
                                }
                            }],
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function (value) {
                                        if (Number.isInteger(value)) {
                                            return value;
                                        }
                                    }
                                }
                            }]
                        },
                        legend: {
                            display: true
                        },
                        animation: {
                            onComplete: function () {
                                $scope.$apply(function () {
                                    $scope.chartLoading = false; 
                                });
                            }
                        }
                    }
                });
            })
            .catch(function (error) {
                console.log(error);
                alertify.error("Error occurred while loading dashboard data.");
                $scope.chartLoading = false; 
            });
    }

    $scope.chartData = [];

    $scope.fetchData = function () {  
        $http.get('/Home/GetChartData')
            .success(function (response) {
                $scope.chartData = response;
                $scope.renderChart();
            });

    };

    $scope.renderChart = function () {
        $scope.chartData;
        var data = $scope.chartData;

        var pieLabels = data.map(function (item) {
            return item.category; 
        });
        var pieData = data.map(function (item) {
            return item.value; 
        });

        var ctx = document.getElementById('myPieChart').getContext('2d');

        if ($scope.myPieChart) {
            $scope.myPieChart.destroy();
        }

        $scope.myPieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: pieLabels,
                datasets: [{
                    data: pieData,
                    backgroundColor: ['#538196', '#2e6878', '#6fa192', '#c8d3db', '#9cbcc8'],
                    hoverBackgroundColor: ['#c9e5f2', '#b6e0f3', '#a3d7ef', '#92d2ef','	#84cbeb'], 
                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                }],
            },
            options: {
                maintainAspectRatio: false,
                tooltips: {
                    backgroundColor: "rgb(255,255,255)",
                    bodyFontColor: "#858796",
                    borderColor: '#dddfeb',
                    borderWidth: 1,
                    xPadding: 15,
                    yPadding: 15,
                    displayColors: false,
                    caretPadding: 10,
                },
                legend: {
                    display: false
                },
                cutoutPercentage: 0, 
            }
        });

    };

    $scope.ForgetPassword = function () {
        data = {
            params: {
                emailAddress: $scope.ForgetPasswordEmail
            }
        };
        debugger;
        $http.get('/Home/ResetPassword', data)
            .success(function (response) {
                if (response === 1) {
                    debugger
                    $scope.ForgetPasswordEmail = undefined;
                    alertify.success("Your Password has send to your Email !!!");
                } else {
                    debugger
                    
                    alertify.error("Enter Valid Email Address !!!");
                }

            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.currentPasswordError = false;
    $scope.confirmPasswordError = false;

    $scope.CheckPassword = function (Password) {

        data = {
            params: {
                enteredCurrentPassword: Password
            }
        };
        //debugger;
        $http.get('/Home/ValidateCurrentPassword', data)
            .success(function (response) {
                if (response === 1) {
                    $scope.currentPasswordError = false;
                    //debugger
                } else {
                    //debugger
                    $scope.currentPasswordError = true;
                }
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.checkVerifyPassword = function () {
        if ($scope.NewPassword2 === $scope.NewPassword1) {
            $scope.confirmPasswordError = false;
        } else {
            $scope.confirmPasswordError = true;
        }
    }

    $scope.UpdateUserPassword = function () {

        if ($scope.NewPassword2 === $scope.NewPassword1) {
            $scope.confirmPasswordError = false;

            data = {
                params: {
                    newPassword: $scope.NewPassword2
                }
            };
            //debugger;
            $http.get('/Home/UpdateUserPassword', data)
                .success(function (response) {
                    if (response === 1) {
                        $scope.CurrentPassword = undefined;
                        $scope.NewPassword2 = undefined;
                        $scope.NewPassword1 = undefined;

                        alertify.success("User password updated successfully", 3000);
                    } else {
                        alertify.success("User password was not updated successfully !!! ", 3000);
                    }
                })
                .error(function (xhr) {
                    console.log(xhr.error);
                })


        } else {
            alertify.error("User password was not match to update !!! ", 3000);
            $scope.confirmPasswordError = true;
        }

    }

});