// ignore: file_names
// ignore_for_file: file_names
//still only one issue to solve, when token expired auth screen not pushed till get out of the app
import 'dart:async';
import 'dart:convert';

import 'package:beeorder_bloc/data/data_providers/auth.dart';
import 'package:beeorder_bloc/data/data_providers/internet_connection.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';

import '../data_providers/database.dart';

class AuthRep {
  Timer? authTimer; //to sign out whenever token is being expired//
  Auth auth = Auth();
  InternetConnection connection = InternetConnection();
  String idToken = '';
  DateTime expireDate = DateTime.now();
  String myUserId = '';
  String username = '';
  String gender = 'Please choose your gender';
  String city = '';
  String email = '';
  DateTime? date;

  String get userId {
    return myUserId;
  }

  repAddUserProfileData() async {
    try {
      final response = await auth.setUserProfileData(
          idToken, userId, username, gender, city, date);
      final resData = jsonDecode(response.body);
      print('rrrrrrrrrrrrrrrrrrrrrrrr$resData');
      username = resData['userName'];
      gender = resData['gender'];
      city = resData['city'];
      if (resData.containsKey('dateofbirth')) {
        date = DateTime(
            resData['dateofbirth']['y'],
            resData['dateofbirth']['m'],
            resData['dateofbirth']['d'],
            resData['dateofbirth']['mi'],
            resData['dateofbirth']['s']);
      }

      print('dooooooooooooooooooooooooooooone');
      return true;
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      return false;
    }
  }

  repGetUserProfileData() async {
    try {
      final response = await auth.getUserProfileData(idToken, userId);
      final resData = jsonDecode(response.body) as Map;
      final response1 = await auth.getUserData(idToken);
      final resData1 = jsonDecode(response1.body);
      print('resData1==$resData1');
      email = resData1['users'][0]['email'];
      print('rrrrrrrrrrrrrrrrrrrrrrrr$resData');
      username = resData['userName'];
      gender = resData['gender'];
      city = resData['city'];
      if (resData.containsKey('dateofbirth')) {
        date = DateTime(
            resData['dateofbirth']['y'],
            resData['dateofbirth']['m'],
            resData['dateofbirth']['d'],
            resData['dateofbirth']['mi'],
            resData['dateofbirth']['s']);
      }
      print('dooooooooooooooooooooooooooooone');
      return true;
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    idToken = '';
    expireDate = DateTime.now();
    authTimer!.cancel();
    myUserId = '';
    try {
      await DBHelper.resetAuthData();
      return true;
    } catch (e) {
      return false;
    }
  }

  autoSigOut() {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpire = expireDate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpire), signOut);
  }

  testInternetConnetion() {
    return connection.hasNetwork();
  }

  Future<bool> autoLogin() async {
    final authData = await DBHelper.getAuthData();
    //  print(authData);
    if (authData.isEmpty) {
      print('empty');
      return false;
    } else if (DateTime.now()
        .add(Duration(seconds: int.parse(authData[0]['expiresIn']!.toString())))
        .isBefore(DateTime.now())) {
      print('token expired');
      return false;
    } else {
      myUserId = authData[0]['userId'].toString();
      idToken = authData[0]['token'].toString();
      expireDate = DateTime.now().add(
          Duration(seconds: int.parse(authData[0]['expiresIn']!.toString())));
      autoSigOut();
      return true;
    }
  }

  Future<String?> repauth({
    required String? sign,
    required String? email,
    required String? password,
  }) async {
    try {
      print('try');
      final resData = (sign == 'sign')
          ? await auth.signIn(email: email, password: password)
          : await auth.signUp(email: email, password: password);
      print('resData=$resData');
      if (resData['error'] == null) {
        idToken = resData['idToken'];
        expireDate = DateTime.now()
            .add(Duration(seconds: int.parse(resData['expiresIn'])));
        print('expireDate==$expireDate');
        print('expireDateee==      ${expireDate.toString()}');
        myUserId = resData['localId'];
        await DBHelper.setAuthData({
          'userId': resData['localId'],
          'token': resData['idToken'],
          'expiresIn': resData['expiresIn']
        });
        final x = await DBHelper.getAuthData();
        print({'x ===   $x'});
        autoSigOut();
        return null;
      } else {
        String e = resData['error']['message'];
        if (e.contains('WEAK_PASSWORD')) {
          e = 'Password is too weak.';
        } else if (e.contains('EMAIL_EXISTS')) {
          e = 'Email already exists';
        } else if (e.contains('EMAIL_NOT_FOUND')) {
          e = 'Email not found';
        } else if (e.contains('INVALID_PASSWORD')) {
          e = 'Password is not correct.';
        } else if (e.contains('INVALID_EMAIL')) {
          e = 'Invalid email';
        } else {
          e = 'Some thing went wrong please try again later';
        }
        return 'Authentication Failed|$e';
      }
    } catch (e) {
      print('catch');
      print(e);
      return 'connection Failed|connection failed please try again later';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      final res = await auth.sendPasswordResetEmail(email);
      if (res.statusCode == 200) {
        print('200');
        return null;
      }
      print('else');
      return 'Some thing went wrong Please try again laterr';
    } catch (e) {
      print('catch');
      return e.toString();
    }
  }

  Future<bool> deleteUser() async {
    print(idToken);
    final response = await auth.deleteUser(idToken);
    if (response.statusCode == 200) {
      //signOut();
      return true;
    } else {
      final resData = jsonDecode(response.body);
      print(resData);
      return false;
    }
  }

  Future<String?> repSendEmailVerifiction() async {
    try {
      final response = await auth.sendEmailVerifiction(idToken);
      if (response.statusCode == 200) {
        return null;
      } else {
        // invalid token or or user not found
        print('elseelse');
        final resData = jsonDecode(response.body);
        print(resData);
        return '${resData['error']['message']}';
      }
    } catch (e) {
      print('catch');
      //throw 'send Email failed $e';
      throw 'send Email failed , please try again';
    }
  }

  Future<bool> repConfirmEmailVerification() async {
    try {
      // print(idToken);
      print('object');
      final response = await auth.getUserData(idToken);
      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));
      print('here');
      if (response.statusCode == 200) {
        final resData = jsonDecode(response.body);
        if ('${resData['users'][0]['emailVerified']}' == 'true') {
          return true;
        } else {
          return false;
        }
      } else {
        // invalid token or user not found
        print(jsonDecode(response.body));
        throw 'Invalid';
      }
    } catch (e) {
      print(e);
      /*if (e.toString().contains('Verification Failed')) {
        rethrow;
      } else {
        throw 'Connection failed|Some thing went wrong Please try again later';
      }*/
      throw 'Verification Failed|$e';
    }
  }
}
