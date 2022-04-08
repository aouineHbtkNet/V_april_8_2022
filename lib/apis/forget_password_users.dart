import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/modals/cart_model.dart';

class ForgetPassword {





  Future <LoginResponseDataModel> InsertCodeAndNewPassword(
      { required String email,
        required String code,
        required String newPassword}

      ) async {
    // this function asks for a code via email.One attribute required :email

    final url = Uri.parse(Constants.SEND_CODE_AND_NEW_PASSWORD_USER);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map<String, dynamic> body = {
      'email': email,
      'recover_code': code,
      'new_password': newPassword,

    };
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    var jsondata = jsonDecode(response.body);
    LoginResponseDataModel adminLoginResponse = LoginResponseDataModel();
    adminLoginResponse = LoginResponseDataModel.fromJson(jsondata);
    return adminLoginResponse;
  }





















  Future    AskForACoDeViaEmail({required String email}) async {
    final url = Uri.parse(Constants.REQUEST_CODE_FOR_USER);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map<String, dynamic> body = {'email': email,};
    final response = await http.post(
        url, headers: headers, body: jsonEncode(body));
    var jsondata = jsonDecode(response.body);
    print(' print alljson of code  $jsondata');


    //  String message = jsondata['message'];
    // print(' print message   $jsondata');

    return jsondata;
  }

}