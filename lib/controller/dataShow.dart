import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xl_sheet_crud_test/Model/getDataForm.dart';
import 'package:xl_sheet_crud_test/Model/teacherForm.dart';

const URLT =
    "https://script.google.com/macros/s/AKfycbwrdvDhJyVkwdl-EgB8g-adf0Lr9EVvNneKJuBGIex8lQ0UMxO3/exec";
const URLS =
    "https://script.google.com/macros/s/AKfycbwrdvDhJyVkwdl-EgB8g-adf0Lr9EVvNneKJuBGIex8lQ0UMxO3/exec?cat=S";

class Fetching {
  Future<List<GetDataForm>> getFeedbackListS() async {
    return await http.get(URLS).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => GetDataForm.fromJson(json)).toList();
    });
  }

  Future<List<FeedbackFormTeacher>> getFeedbackListT() async {
    return await http.get(URLT).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback
          .map((json) => FeedbackFormTeacher.fromJson(json))
          .toList();
    });
  }
}
