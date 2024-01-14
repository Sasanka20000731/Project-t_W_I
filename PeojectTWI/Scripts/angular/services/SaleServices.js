myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {

    $scope.Discount = 0;

    $scope.LoadData = function () {

        $scope.HideValidation(1)


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
            $scope.Price = $scope.Price - $scope.Discount;
        }
    }

    $scope.Profit = function (price) {
        if (price !== 0) {
            var profit = price / 100 * 25;
            return profit;
        }
    }

    $scope.SaleItem = function () {
        data = {
            params: {
                cName: CoustomerName,
                cContact: CoustomerContact,
                cEmail: CoustomerEmail,
                cAddress: CoustomerAddress,
                cbackUpccontact: CoustomerBackupContact,
                SerialNo: $scope.SerialNumber,
                Discount: $scope.Discount,
                Price: $scope.Price,
                Warrenty: $scope.radio

            }
        };
        $http.get('/Sale/SaveSaleItem', data)
            .success(function (response) {
     

            }).error(function (xhr) {
                console.log(xhr.error);
                alertify.error($scope.popMessage, 3000);
            })


    }







});