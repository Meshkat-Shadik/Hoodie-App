import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:xl_sheet_crud_test/Model/getDataForm.dart';
import 'package:xl_sheet_crud_test/controller/Search.dart';
import 'package:xl_sheet_crud_test/controller/dataShow.dart';
import 'package:xl_sheet_crud_test/controller/form_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sms/flutter_sms.dart';

class StudentInfo extends StatefulWidget {
  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  final List<String> cat = ['CustomerName', 'Size', 'Host'];
  String currcat;
  List<GetDataForm> feedbackItems = List<GetDataForm>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Fetching().getFeedbackListS().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  Future<void> showMyDialog(String name, String number) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: Text(number),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    launch("tel://" + (number));
                  },
                  child: Text('Call')),
              FlatButton(
                  onPressed: () {
                    launch("sms://" + (number));
                  },
                  child: Text('Message')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //print(feedbackItems);
    return feedbackItems.isEmpty
        ? Scaffold(
            body: Center(
              child: Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.all(100),
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator()),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black54,
              title: DropdownButtonFormField(
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                style: TextStyle(color: Colors.white),
                icon: Icon(Icons.filter),
                hint: Text(
                  'Search Filter',
                  style: TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.blueGrey,
                items: cat.map((ele) {
                  return DropdownMenuItem(child: Text(ele), value: ele);
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    currcat = val;
                  });
                },
              ),
              actions: [
                IconButton(
                    icon:
                        feedbackItems.isEmpty ? Icon(null) : Icon(Icons.search),
                    onPressed: () {
                      List<GetDataForm> feedbackItems2 = List<GetDataForm>();
                      feedbackItems.removeLast();
                      feedbackItems2 = feedbackItems;
                      showSearch(
                          context: context,
                          delegate: Search(feedbackItems2, currcat));
                    })
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 100,
                    //   height: 50,
                    // margin: EdgeInsets.all(20),
                    // //  color: Colors.red,
                    //   child: RaisedButton(
                    //     onPressed: (){
                    //       print("Hello Check 123 Hoodie App Testing, Your Name is ${feedbackItems.map((e) => e.name)}");
                    //       print("Hello Check 123 Hoodie App Testing, Your Phone is ${feedbackItems.map((e) => e.phone)}");
                    //       print("Hello Check 123 Hoodie App Testing, Your Id is ${feedbackItems.map((e) => e.sn)}");
                    //     },
                    //     child: Text('Message All')
                    //
                    //     ,),
                    // ),
                    DataTable(
                      columns: [
                        //   DataColumn(label: Text('Delivered?')),
                        DataColumn(label: Text('SN')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Class/Batch(SSC)')),
                        DataColumn(label: Text('Size')),
                        DataColumn(label: Text('phone')),
                        DataColumn(label: Text('Hoodie Price')),
                        DataColumn(label: Text('Payment Way')),
                        DataColumn(label: Text('Pickup Cost')),
                        DataColumn(label: Text('Method')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Host')),

                        //  DataColumn(label: Text('')),
                        //
                      ],
                      rows: List<DataRow>.generate(
                        feedbackItems.length - 1,
                        (index) => DataRow(
                          // color: feedbackItems[index].done!=''?Color(Colors.white):Colors.green,
                          // color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          //   if (states.contains(MaterialState.selected))
                          //     return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                          //   return null;  // Use the default value.
                          // }
                          //   color: MaterialStateColor.resolveWith((states) =>feedbackItems[index].done!=''?Theme.of(context).colorScheme.copyWith(primary: Colors.red).primary.withOpacity(0.5):Theme.of(context).colorScheme.copyWith(primary: Colors.transparent).primary),
                          cells: <DataCell>[
                            //      DataCell(feedbackItems[index].done!=''?Text(''):RaisedButton(child: Text('YES'),onPressed: feedbackItems[index].done!=''?null: ()async{ await http.post("https://script.google.com/macros/s/AKfycbwrdvDhJyVkwdl-EgB8g-adf0Lr9EVvNneKJuBGIex8lQ0UMxO3/exec?name=&batch=&size=&phone=&price=&paymentWay=&pickupCost=&method=&address=&host=&cat=S&done=${(feedbackItems.length-1-index).toString()}").then((response) {
                            //Your stuff

                            //     setState(() {}); //refresh
                            // Navigator.popAndPushNamed(context, '/');
                            //     })

                            // ;},)),
                            DataCell(Text(
                                (feedbackItems.length - 1 - index).toString())),
                            DataCell(Text(feedbackItems[index]
                                .name)), //Extracting from Map element the value
                            DataCell(Text(feedbackItems[index].batch)),
                            DataCell(Text(feedbackItems[index].size)),
                            DataCell(Text('0' + feedbackItems[index].phone),
                                onTap: () {
                              showMyDialog(feedbackItems[index].name,
                                  ('0' + feedbackItems[index].phone));
                            }), //Extracting from Map element the value
                            DataCell(Text(feedbackItems[index].price)),
                            DataCell(Text(feedbackItems[index].paymentWay)),
                            DataCell(Text(feedbackItems[index]
                                .pickupCost)), //Extracting from Map element the value
                            DataCell(Text(feedbackItems[index].method)),
                            DataCell(Text(feedbackItems[index].address)),
                            DataCell(Text(feedbackItems[index].host)),
                          ],
                        ),
                        //UrlLauncher.launch('tel:+${('0'+feedbackItems[index].phone).toString()}');
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('dasdasd'),
    //   ),
    //   body: ListView.builder(
    //     itemCount: feedbackItems.length,
    //     itemBuilder: (context, index) {
    //       return this.feedbackItems==null?
    //       CircularProgressIndicator():
    //       ListTile(
    //         title: Row(
    //           children: <Widget>[
    //             Icon(Icons.person),
    //             Expanded(
    //               child: Text(
    //                   "${feedbackItems[index].name} (${feedbackItems[index].name})"),
    //             )
    //           ],
    //         ),
    //         subtitle: Row(
    //           children: <Widget>[
    //             Icon(Icons.message),
    //             Expanded(
    //               child: Text(feedbackItems[index].size),
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
