var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'StravaAuth', 'coolMethod', [arg0]);
};

exports.authorizeStrava = function (userId, callbackUri, success, error) {
    exec(success, error, 'StravaAuth', 'authorize', [userId, callbackUri]);
};
