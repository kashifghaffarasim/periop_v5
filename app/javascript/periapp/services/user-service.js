periop.factory("UserService", function ($http, $q, $apiRoot) {
    var resourcePath = $apiRoot + "/users";
    return {
        register: function (user) {
            var url = resourcePath + "/register";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    user: user,
                }
            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {
                defer.reject(data);
            });
            return defer.promise;
        },
        signin: function (user) {
            var url = resourcePath + "/authenticate";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    user: user,
                }
            }).success(function (data, status, header, config) {

                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        forgetpassword: function (email) {
            var url = resourcePath + "/forgot_password";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    email: email,
                }
            }).success(function (data, status, header, config) {

                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        contactus: function (contact) {
            var url = resourcePath + "/contact";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    contact: contact,
                }
            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        get_fans_list: function () {
            var url = resourcePath + "/fans_list";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        get_users_list: function () {
            var url = resourcePath + "/users_list";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        get_admins_list: function () {
            var url = resourcePath + "/admins_list";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        get_artists_list: function () {
            var url = resourcePath + "/artists_list";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        delete: function (id) {
            var url = resourcePath + "/" + id;
            var defer = $q.defer();
            $http({
                method: 'DELETE',
                url: url

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        resetpassword: function (user) {
            var url = resourcePath + "/reset_password";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    user: user
                }

            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {

                defer.reject(data);
            });
            return defer.promise;
        },
        changePassword: function (newPassword, token) {
            var url = resourcePath + "/update_password/";
            var defer = $q.defer();
            $http({
                method: 'POST',
                url: url,
                data: {
                    password: newPassword,
                    token: token
                }
            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {
                defer.reject(data);
            });
            return defer.promise;
        },
    };
});