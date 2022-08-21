import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  setUserProfileData(String token, String userId, String userName,
      String gender, String city, DateTime? date) async {
    Uri url = Uri.parse(
        'https://shopapp-1dd1c-default-rtdb.firebaseio.com/userData/$userId.json?auth=$token');
    try {
      final http.Response response = await http.put(
        url,
        body: jsonEncode(
          date == null
              ? {
                  'userName': userName,
                  'gender': gender,
                  'city': city,
                }
              : {
                  'userName': userName,
                  'gender': gender,
                  'city': city,
                  'dateofbirth': {
                    'y': date.year,
                    'm': date.month,
                    'd': date.day,
                    'h': date.hour,
                    'mi': date.minute,
                    's': date.second,
                  }
                },
        ),
      ); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(response
          .body);*/ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getUserProfileData(String token, String userId) async {
    Uri url = Uri.parse(
        'https://shopapp-1dd1c-default-rtdb.firebaseio.com/userData/$userId.json?auth=$token');
    try {
      final http.Response response = await http.get(
        url,
      ); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(response
          .body);*/ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future authentication({
    required String? sign,
    required String? email,
    required String? password,
  }) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$sign?key=AIzaSyAXbHK5lYtQZYDr6u7k_iFFg-T-rFD5iYg');
    try {
      print('try out');
      final value = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          })); //here if there is no internet connection an Exception will thrown//
      print('value=${value.body}');
      final resData = jsonDecode(value
          .body); //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return resData;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> sendPasswordResetEmail(String email) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyAXbHK5lYtQZYDr6u7k_iFFg-T-rFD5iYg');
    try {
      final http.Response response = await http.post(url,
          body: jsonEncode({
            'requestType': "PASSWORD_RESET",
            'email': email
          })); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(response
          .body);*/ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteUser(String token) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=AIzaSyAXbHK5lYtQZYDr6u7k_iFFg-T-rFD5iYg');
    try {
      final http.Response response = await http.post(url,
          body: jsonEncode({
            'idToken': token,
          })); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(response
          .body);*/ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future signIn({
    required String? email,
    required String? password,
  }) async {
    return authentication(
        sign: 'signInWithPassword', email: email, password: password);
  }

  Future signUp({
    required String? email,
    required String? password,
  }) async {
    return authentication(sign: 'signUp', email: email, password: password);
  }

  Future<http.Response> sendEmailVerifiction(String idToken) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyAXbHK5lYtQZYDr6u7k_iFFg-T-rFD5iYg');
    try {
      final http.Response value = await http.post(url,
          body: jsonEncode({
            'requestType': 'VERIFY_EMAIL',
            'idToken': idToken,
          })); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(value
          .body);*/ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return value;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getUserData(String idToken) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyAXbHK5lYtQZYDr6u7k_iFFg-T-rFD5iYg');
    try {
      final http.Response value = await http.post(url,
          body: jsonEncode({
            'idToken': idToken,
          })); //here if there is no internet connection an Exception will thrown//

      /* final resData = jsonDecode(value
          .body); */ //here if there is a problem in the connection (vpn is not applied)to the internet an Exception will thrown//

      return value;
    } catch (e) {
      rethrow;
    }
  }
}
