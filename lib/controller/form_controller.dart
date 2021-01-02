import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xl_sheet_crud_test/Model/form.dart';
import '../Model/form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {

  // Google App Script Web URL.
 static const String URL = "https://script.google.com/macros/s/AKfycbw2CPx5KLSN-E94u06hf1xReW4Cg6l9a14Gr5_Yx5t6s-KrLSY/exec";
  //static const String URL = "https://script.google.com/macros/s/AKfycbxD-p9eVBBGTBETWd9oyHhrLpAknhYChAxTnQpI/exec";
  static const STATUS_SUCCESS = "SUCCESS";
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

}