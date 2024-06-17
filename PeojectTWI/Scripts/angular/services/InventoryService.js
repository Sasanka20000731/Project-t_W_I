myApp.controller("MyController", function ($scope, $http, $uibModal, $uibModalStack, $rootScope) {

    $scope.Active = false;

    $scope.PageLoad = function () {
        $http.get('/Inventory/GetProductCategoryValues')
        .success(function (response) {
            $scope.TypeChoices = response;
        }).error(function (xhr) {
            console.log(xhr.error);
        })

        //$http.get('/Inventory/GetmasterStoreValues')
        //.success(function (response) {
        //    $scope.TypeChoices2 = response; 
        //}).error(function (xhr) {
        //    console.log(xhr.error);
        //})
    };

    $scope.CheckData = function () {
        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                SerialNo: $scope.SerialNumber
            }
        };

        $http.get('/Inventory/CheckExist', data)

            .success(function (response) {
             //   debugger
                if (response == "Already in the store") {
                    alertify.success('Already in the store', 3000);
                    $scope.disableSave = true;
                }
                else if (response == "Already not in the store") {
                    alertify.success('Already not in the store', 3000);
                    $scope.disableSave = true;

                } else {
                    $scope.disableSave = false;

                }

            }).error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.SaveData = function () {

        $scope.CheckData();

        data = {
            params: {
                dataType: $scope.RadioValue,
                ProductCategory: $("#droproductCategory").val(),
                SerialNo: $scope.SerialNumber
            }
        };
        $http.get('/Inventory/ManageWareHouseData', data)
            .success(function (response) {
                $scope.popMessage = response;
               // debugger;
                alertify.success($scope.popMessage, 3000);
                $scope.ClearWHManageForm();
            }).error(function (xhr) {
                console.log(xhr.error);
            })
    }

    $scope.WHManageDataLoad = function () {
        data = {
            params: {
                FromDate: null,
                Todate: null
            }
        };
        $http.get('/Inventory/ViewWareHousedata', data)
        .success(function (response) {
            $scope.Result = response;
        })
        .error(function (xhr) {
            console.log(xhr.error);
        })

    }

    $scope.ClearWHManageForm = function () {
        //debugger;
        $scope.RadioValue = undefined;
        $scope.SerialNumber = undefined;
       // $("#droproductCategory").val() =;
  
        $scope.droproductCategory = '';

    }

    $scope.SaveProductCategory = function () {

        if (($scope.ProductName != null && $scope.BrandName != null && $scope.VendorName != null && $scope.VendorContact != null && $scope.VendorAddress != null && $scope.VendorEmail != null)

            || ($scope.ProductName != undefined && $scope.BrandName != undefined && $scope.VendorName != undefined && $scope.VendorContact != undefined && $scope.VendorAddress != undefined && $scope.VendorEmail != undefined)) {
            data = {
                params: {
                    ProductName: $scope.ProductName,
                    BrandName: $scope.BrandName,
                    VendorName: $scope.VendorName,
                    VendorContact: $scope.VendorContact,
                    VendorAddress: $scope.VendorAddress,
                    VendorEmail: $scope.VendorEmail
                }
            };
            debugger;
            $http.get('/Inventory/SaveProductCategory', data)
                .success(function (response) {
                    if (response == 1) {
                        alertify.success("Successfully Saved Product Category", 3000);
                        $scope.ClearProductCategory();
                    } else {
                        alertify.error("Error", 3000);
                    }
                }).error(function (xhr) {
                    alertify.error("Error", 3000);
                    console.log(xhr.error);
                })
        }else {
            alertify.error("Fill All Data", 3000);
        }
    }

    $scope.ClearProductCategory = function () {
        $scope.ProductName = undefined;
        $scope.BrandName = undefined;
        $scope.VendorName = undefined;
        $scope.VendorContact = undefined;
        $scope.VendorAddress = undefined;
        $scope.VendorEmail = undefined;

    }

    $scope.validateMobileNumber = function () {
        if (($scope.VendorContact && $scope.VendorContact.length === 10 && /^\d+$/.test($scope.VendorContact) && $scope.VendorContact.startsWith('0')) || ($scope.VendorContact === undefined) || ($scope.VendorContact === "")) {
            $scope.mobileNumberAsyncError = false;
            $scope.mobileNumberAsyncErrorMessage = "";
        } else {

            $scope.mobileNumberAsyncError = true;
            $scope.mobileNumberAsyncErrorMessage = "Mobile number should be 10 digits and valid mobile number!!!";
        }

    };

    $scope.validateEmail = function () {
       
        if (!$scope.VendorEmail || $scope.VendorEmail.trim() === "") {
            $scope.EmailAsyncError = true;
            $scope.EmailAsyncErrorMessage = "Enter Valid Email Address!!!";
        } else {
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

            if (emailPattern.test($scope.VendorEmail)) {
                $scope.EmailAsyncError = false;
                $scope.EmailAsyncErrorMessage = "";
            } else {
                $scope.EmailAsyncError = true;
                $scope.EmailAsyncErrorMessage = "Enter a Valid Email Address!!!";
            }
        }
    };

    $scope.loadProductCategoryDetails = function () {
       
        data = {
            params: {
                ProductID: $("#ProductID").val()
            }
        };
        //debugger
        $http.get('/Inventory/getselectedProductCategoryDetails', data)
            .success(function (response) {
                //debugger;
                $scope.ProductName = response[0].ProductName;
                $scope.BrandName = response[0].BrandName;
                $scope.VendorName = response[0].VendorName;
                $scope.VendorContact = response[0].VendorContact;
                $scope.VendorAddress = response[0].VendorAddress;
                $scope.VendorEmail = response[0].VendorEmail;
                $scope.Active = response[0].Active;
            })
            .error(function (xhr) {
                console.log(xhr.error);
            })

    }

    $scope.UpdateProductCategory = function () {
        debugger
        if (($("#ProductID").val() != null && $scope.BrandName != null && $scope.VendorName != null && $scope.VendorContact != null && $scope.VendorEmail != null && $scope.VendorAddress != null  && $scope.ProductName != null)
            || ($("#ProductID").val() != undefined && $scope.BrandName != undefined && $scope.VendorName != undefined && $scope.VendorContact != undefined && $scope.VendorEmail != undefined && $scope.VendorAddress != undefined && $scope.ProductName != undefined)) {

            $scope.Active;
            if ($scope.Active == undefined) {
                $scope.Active = false;
            }
            //debugger
            var extendUrl = '/Inventory/EditProductCategorys?' +
                'ProductID=' + $("#ProductID").val() +
                '&BrandName=' + $scope.BrandName +
                '&VendorName=' + $scope.VendorName +
                '&VendorContact=' + $scope.VendorContact +
                '&VendorEmail=' + $scope.VendorEmail +
                '&VendorAddress=' + $scope.VendorAddress +
                '&Active=' + $scope.Active +
                '&ProductName=' + $scope.ProductName;
            //debugger;
            //'&Active=' + $scope.Active;
            //debugger;
            window.location.href = extendUrl;
        } else {
            alertify.error("Plese fill all feilds to update", 4000);

        }
        
    }

    $scope.SearchSerialNumber = function () {

        if ($scope.SerialNumberToSearch != null || $scope.SerialNumberToSearch != undefined) {
            data = {
                params: {
                    SerialNumberToSearch: $scope.SerialNumberToSearch
                }
            };
            $http.get('/Inventory/GetSearchSerialDetails', data)
                .success(function (response) {

                    if (response.length != 0) {
                        $scope.SearchedItemDetails = response[0];
                    } else {
                        alertify.success("No Records Available For This Serial Number !!!", 6000);
                    }

                })
                .error(function (xhr) {
                    alertify.success("Error !!!", 3000);
                    console.log(xhr.error);
                })

        } else {
            alertify.success("Plese Enter Serial Number", 4000);
        }

       

    }

    $scope.ClearSearchInventory = function () {
        $scope.SerialNumberToSearch = undefined;
        $scope.SearchedItemDetails = undefined;
    }

    $scope.LoadRemainigStock = function () {
        debugger
        $http.get('/Inventory/LoadRemainigStock')
            .success(function (response) {
             debugger

            })
            .error(function (xhr) {
                alertify.success("Error !!!", 3000);
                console.log(xhr.error);
            })

    }


});

