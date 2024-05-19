myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {

    $scope.Discount = 0;
       
    $scope.CheckEmail = function (CustomerEmail) {
        data = {
            params: {
                EmailAddress: CustomerEmail
            }
        };
        $http.get('/Home/CheckValidEmail', data)
            .success(function (response) {
                if (response === "True") {
                    $scope.EmailAsyncError = false;
                    $scope.EmailAsyncErrorMessage = "";
                } else {
                    $scope.EmailAsyncError = true;
                    $scope.EmailAsyncErrorMessage = "Enter a Valid Email Address!!!";
                }
            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.error('Error', 3000);
            })

    };

    $scope.LoadData = function () {

        $scope.HideValidation(1);
        $scope.HideValidationDiscount(1);

        $http.get('/Sale/getSaleData')
            .success(function (response) {
                //$scope.TypeChoices = response;


            }).error(function (xhr) {
                //console.log(xhr.error);
            })
    }

    $scope.GetProductDetails = function () {
        data = {
            params: {
                SerialNo: $scope.SerialNumber
            }
        };
        $http.get('/Sale/GetProductDetailsToSale', data)
            .success(function (response) {
                if (response.length > 0) {
                    $scope.Result = response;
                    $scope.Productname = response[0].ProductName;
                    $scope.unitPrice = response[0].unitPrice;

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

    $scope.HideValidationDiscount = function (x) {
        if (x == 1) {
            $scope.validationMessageDiscount = true;

        } else {
            $scope.validationMessageDiscount = false;

        }

    }

    $scope.PriceCalculation = function (x) {
        $scope.warrentyCharge(x);
        if (x === 1 || x === "1") {
            $scope.RowPrice = $scope.warrentyCharge(x) + $scope.unitPrice;
            $scope.Price = $scope.Profit($scope.RowPrice) + $scope.RowPrice;
            $scope.originalValue = $scope.Price;
        }
        else if (x === 2 || x === "2") {
            $scope.RowPrice = $scope.warrentyCharge(x) + $scope.unitPrice;
            $scope.Price = $scope.Profit($scope.RowPrice) + $scope.RowPrice;
            $scope.originalValue = $scope.Price;

        } else if (x === 3 || x === "3") {
            $scope.RowPrice = $scope.warrentyCharge(x) + $scope.unitPrice;
            $scope.Price = $scope.Profit($scope.RowPrice) + $scope.RowPrice;
            $scope.originalValue = $scope.Price;

        }

    }

    $scope.warrentyCharge = function (x) {

        if (x === 1) {
            $scope.WarrentyChage = $scope.unitPrice / 100 * 10;
            return $scope.WarrentyChage;
        }
        else if (x === 2) {
            $scope.WarrentyChage = $scope.unitPrice / 100 * 20;
            return $scope.WarrentyChage;

        } else if (x === 3) {
            $scope.WarrentyChage = $scope.unitPrice / 100 * 30;
            return $scope.WarrentyChage;
        }

    }

    $scope.DiscountManageCalculator = function () {
         
        var max = $scope.unitPrice / 100 * 10;
        if ($scope.Discount > max) {
            $scope.Price = $scope.originalValue;
            $scope.HideValidationDiscount(2);
        } else {
            $scope.HideValidationDiscount(1);
            $scope.Price = $scope.originalValue - $scope.Discount;
        }
    }

    $scope.Profit = function (price) {
        if (price !== 0) {
            var profit = price / 100 * 25;
            return profit;
        }
    }

    $scope.SaleItem = function () {

        if (($scope.CoustomerName != null && $scope.CoustomerContact != null && $scope.CustomerEmail != null && $scope.CoustomerAddress != null && $scope.SerialNumber != null && $scope.Price != null && $scope.radio != null)
            || ($scope.CoustomerName != undefined && $scope.CoustomerContact != undefined && $scope.CustomerEmail != undefined && $scope.CoustomerAddress != undefined && $scope.SerialNumber != undefined && $scope.Price != undefined && $scope.radio != undefined)) {

            data = {
                params: {
                    cName: $scope.CoustomerName,
                    cContact: $scope.CoustomerContact,
                    CustomerEmail: $scope.CustomerEmail,
                    cAddress: $scope.CoustomerAddress,
                    SerialNo: $scope.SerialNumber,
                    Discount: $scope.Discount,
                    Price: $scope.Price,
                    Warrenty: $scope.radio

                }
            };

            $http.get('/Sale/SaveSaleItem', data)
                .success(function (response) {
                    if (response === 1) {
                        alertify.success('Success', 3000);
                        $scope.resetForm();
                    } else {
                        alertify.error('Error', 3000);
                        console.log(xhr.error);
                    }
                }).error(function (xhr) {
                    console.log(xhr.error);
                    alertify.error('Error', 3000);
                })

        } else {
            alertify.error('Fill Required Data !!!', 3000);
        }
        
    }

    $scope.resetForm = function () {
        $("#name").val("");
        $("#number").val("");
        $("#email").val("");
        $("#serialNumber").val("");
        $("#address").val("");
        $("#productName").val("");
        $scope.radio = 0;
        $("#discount").val("");
        $("#price").val("");
        $("#productName").val("");
    }

    $scope.SearchSale = function () {
        if ($scope.SerialNumber != undefined || $scope.InvoiceNumber != undefined || $scope.ContactNumber != undefined) {

            data = {
                params: {
                    SerialNo: $scope.SerialNumber,
                    InvoiceNocContact: $scope.InvoiceNumber,
                    ContactNo: $scope.ContactNumber
                }
            };
            $http.get('/Sale/GetSoldItemDataTable', data)
                .success(function (response) {
                    if (response.length != 0) {
                        $scope.LoadedData = response;
                    } else {
                            alertify.error('No record found !!!', 3000);
                    }
                })
                .error(function (xhr) {
                    console.log(xhr.error);
                    alertify.error('Error', 3000);
                })

        } else {
            alertify.error('Please Fill Data To Search', 3000);
        }
        
    }

    $scope.SearchDetails = function (x) {
        var Serial = x;
        data = {
            params: {
                SerialNo: Serial
            }
        };
        $http.get('/Sale/GetSelectedSoldItemData', data)
            .success(function (response) {
                $scope.serialNumberToDisplay = response[0].SerialNumber;
                $scope.saleDate = response[0].SoldDate;
                $scope.customerName = response[0].CoustomerName;
                $scope.customerNumber = response[0].ContactNumber;
               
            })
            .error(function (xhr) {
                console.log(xhr.error);
                alertify.error('Error', 3000);
            })
    }

    $scope.rejectSaleItem = function () {
    
        data = {
            params: {
                SerialNumber: $scope.serialNumberToDisplay
            }
        };
        $http.get('/Sale/RejectSale', data)
            .success(function (response) {
                if (response === 1) {
                    alertify.success('Successfully Removed', 3000);
                    $scope.ClearRemoveSaleForm();
                } else {
                    alertify.error('Error', 3000);
                    console.log(xhr.error);
                }

            })
            .error(function (xhr) {
                console.log(xhr.error);
                alertify.error('Error', 3000);
            })
    }

    $scope.ClearRemoveSaleForm = function () {
        $scope.LoadedData = undefined;
        $scope.serialNumberToDisplay = undefined;
        $scope.SerialNumber = undefined;
        $scope.ContactNumber = undefined;
        $scope.InvoiceNumber = undefined;
        $scope.saleDate = undefined;
        $scope.customerName = undefined;
        $scope.customerNumber = undefined;

    }

    $scope.validateMobileNumber = function () {
        if (($scope.CoustomerContact && $scope.CoustomerContact.length === 10 && /^\d+$/.test($scope.CoustomerContact) && $scope.CoustomerContact.startsWith('0')) || ($scope.CoustomerContact === undefined) || ($scope.CoustomerContact === "")) {
            $scope.mobileNumberAsyncError = false;
            $scope.mobileNumberAsyncErrorMessage = "";
        } else {

            $scope.mobileNumberAsyncError = true;
            $scope.mobileNumberAsyncErrorMessage = "Mobile number should be 10 digits and valid mobile number!!!";
        }

    };

});