/*
* name;
*/
var DataManager;
(function (DataManager) {
    var CookieManager = /** @class */ (function () {
        function CookieManager() {
            console.log("Successfully construct CookieManager");
            this.m_nDefaultExistDays = 1;
        }
        CookieManager.prototype.SignIn = function (_sAccount, _sPassword) {
            if (_sAccount == null) {
                _sAccount = "";
            }
            if (_sPassword == null) {
                _sPassword = "";
            }
            document.cookie = encodeURIComponent(_sAccount) + "=" + encodeURIComponent(_sPassword) + "; path=/ ; Domain = .google.com";
            console.log("欲寫入的cookie帳號為" + _sAccount + " 密碼則是" + _sPassword);
        };
        CookieManager.prototype.SignOut = function () {
        };
        CookieManager.prototype.Read = function (_sKey) {
            var sOutputValue = "";
            var arrResult = new RegExp('(?:^|; )(' + encodeURIComponent(_sKey) + ')=([^;]*)').exec(document.cookie);
            if (arrResult != null) {
                // console.log(arrResult[0]);
                // console.log(arrResult[1]);
                // console.log(arrResult[2]);
                // console.log(arrResult[3]);
                sOutputValue = arrResult[2];
                return sOutputValue;
            }
            else {
                return null;
            }
        };
        CookieManager.prototype.Write = function (_sKey, _sValue, _nExistDays) {
            if (!_nExistDays) {
                this.Write(_sKey, _sValue, this.m_nDefaultExistDays);
            }
            else {
                var dateExpires = new Date();
                dateExpires.setTime(dateExpires.getTime() + (_nExistDays * 24 * 60 * 60 * 1000));
                var sExpires = "; expires=" + dateExpires.toUTCString(); //將日期轉為GMT格林威治標準時間
                document.cookie = encodeURIComponent(_sKey) + "=" + encodeURIComponent(_sValue) + sExpires + "; path=/";
            }
        };
        CookieManager.prototype.Remove = function (_sKey) {
            this.Write(_sKey, "", -1);
        };
        return CookieManager;
    }());
    DataManager.CookieManager = CookieManager;
})(DataManager || (DataManager = {}));
//# sourceMappingURL=CookieManager.js.map