import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xl_sheet_crud_test/Model/getDataForm.dart';
import 'package:xl_sheet_crud_test/Model/teacherForm.dart';


const URLT= "https://script.google.com/macros/s/AKfycbw2CPx5KLSN-E94u06hf1xReW4Cg6l9a14Gr5_Yx5t6s-KrLSY/exec";
const URLS = "https://script.google.com/macros/s/AKfycbw2CPx5KLSN-E94u06hf1xReW4Cg6l9a14Gr5_Yx5t6s-KrLSY/exec?cat=S";
class Fetching
{
  Future<List<GetDataForm>> getFeedbackListS() async {
    return await http.get(URLS).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => GetDataForm.fromJson(json)).toList();
    });
  }
  Future<List<FeedbackFormTeacher>> getFeedbackListT() async {
    return await http.get(URLT).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackFormTeacher.fromJson(json)).toList();
    });
  }
}