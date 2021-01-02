import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:xl_sheet_crud_test/Model/teacherForm.dart';
import 'package:xl_sheet_crud_test/controller/Search.dart';
import 'package:xl_sheet_crud_test/controller/dataShow.dart';
import 'package:xl_sheet_crud_test/controller/form_controller.dart';

class TeachersInfo extends StatefulWidget {
  @override
  _TeachersInfoState createState() => _TeachersInfoState();
}

class _TeachersInfoState extends State<TeachersInfo> {
  List<FeedbackFormTeacher> feedbackItemsTeacher = List<FeedbackFormTeacher>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Fetching().getFeedbackListT().then((feedbackItems) {
      setState(() {
        this.feedbackItemsTeacher = feedbackItems;
      });
    });
  }

  Future<void>showMyDialog(String name, String number) async{
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text(name),
            content: Text(number),
            actions:<Widget> [
              FlatButton(onPressed: (){launch("tel://"+(number));}, child: Text('Call')),
              FlatButton(onPressed: (){launch("sms://"+(number));}, child: Text('Message')),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(feedbackItemsTeacher);
    return feedbackItemsTeacher.isEmpty?
    Scaffold(
      body: Center(
        child: Container(
            height: 50,
            width: 50,margin: EdgeInsets.all(100),
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator()
        ),
      ),
    ):
    Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(

          child:DataTable(

            columns: [
              //   DataColumn(label: Text('Delivered?')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('School/College')),
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('Logo')),
                  DataColumn(label: Text('phone')),
                  DataColumn(label: Text('Hoodie Price')),
                  DataColumn(label: Text('Payment Way')),

                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Host')),

              //  DataColumn(label: Text('')),
              //
            ],
            rows:
            List<DataRow>.generate(
              feedbackItemsTeacher.length-1,
                  (index) => DataRow(
                cells:<DataCell> [
                  DataCell(Text(feedbackItemsTeacher[index].name)), //Extracting from Map element the value
                  DataCell(Text(feedbackItemsTeacher[index].sc)),
                  DataCell(Text(feedbackItemsTeacher[index].size)),
                  DataCell(Text(feedbackItemsTeacher[index].logo)),
                  DataCell(Text('0'+feedbackItemsTeacher[index].phone),onTap: (){showMyDialog(feedbackItemsTeacher[index].name,('0'+feedbackItemsTeacher[index].phone));}), //Extracting from Map element the value
                  DataCell(Text(feedbackItemsTeacher[index].price)),
                  DataCell(Text(feedbackItemsTeacher[index].paymentWay)),
             //     DataCell(Text(feedbackItemsTeacher[index].pickupCost)), //Extracting from Map element the value
             //     DataCell(Text(feedbackItemsTeacher[index].method)),
                  DataCell(Text(feedbackItemsTeacher[index].address)),
                  DataCell(Text(feedbackItemsTeacher[index].host)),
                ],

              ),
              //UrlLauncher.launch('tel:+${('0'+feedbackItems[index].phone).toString()}');
            ),

          ),
          // child: DataTable(
          //
          //   columns: [
          //     DataColumn(label: Text('Name')),
          //     DataColumn(label: Text('School/College')),
          //     DataColumn(label: Text('Size')),
          //     DataColumn(label: Text('Logo')),
          //     DataColumn(label: Text('phone')),
          //     DataColumn(label: Text('Hoodie Price')),
          //     DataColumn(label: Text('Payment Way')),
          //
          //     DataColumn(label: Text('Address')),
          //     DataColumn(label: Text('Host')),
          //
          //     //  DataColumn(label: Text('')),
          //   ],
          //   rows:
          //   // Loops through dataColumnText, each iteration assigning the value to element
          //   feedbackItemsTeacher.map(
          //     ((element) => DataRow(
          //       cells: <DataCell>[
          //         DataCell(Text(element.name)), //Extracting from Map element the value
          //         DataCell(Text(element.sc)),
          //         DataCell(Text(element.size)),
          //         DataCell(Text(element.logo)),
          //         DataCell(Text(element.phone)), //Extracting from Map element the value
          //         DataCell(Text(element.price)),
          //         DataCell(Text(element.paymentWay)),
          //         //Extracting from Map element the value
          //         DataCell(Text(element.address)),
          //         DataCell(Text(element.host)), //Extracting from Map element the value
          //         //    DataCell(Text(element.size)),
          //       ],
          //     )),
          //   ) .toList(),
          // ),
        ),
      ),
    );

  }
}
