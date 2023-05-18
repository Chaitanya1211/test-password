import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  checkAvailability(String username) async {
    Map getapidata = {};
    getapidata['username'] = username;
    var registerData =
        await _performRequest('GET', 'register/check', getapidata);
    return registerData["message"];
  }

  registerUser(String username, String publicKey) async {
    Map getapidata = {};
    getapidata['username'] = username;
    getapidata['publicKey'] = publicKey;
    var registerResult =
        await _performRequest('POST', 'register/new', getapidata);
    // print(registerResult);
    return registerResult;
  }

  getSecret(String username) async {
    Map getapidata = {};
    getapidata['username'] = username;
    var secretResult = await _performRequest('GET', 'login/secret', getapidata);
    return secretResult;
  }

  verifySecret(String username, String decryptedText) async {
    print("Verify secret called");
    Map getapidata = {};
    if (username == "Chaitanya") {
      getapidata['flag'] = 1;
    } else {
      getapidata['flag'] = 0;
    }
    getapidata['username'] = username;
    getapidata['decryptedText'] = decryptedText;

    var res = await _performRequest('GET', 'login/verify', getapidata);
    print(res);
    return res;
  }

  _performRequest(String reqType, String endUrl, Map getapidata) async {
    var baseUrl = "http://13.126.213.4/";

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(reqType, Uri.parse('$baseUrl$endUrl'));

    request.body = jsonEncode(getapidata);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Response recieved");
      var datafinal = await response.stream.bytesToString();
      var data = jsonDecode(datafinal);
      return data;
    }
    print("Response not recieved");
    return {};
  }
}
