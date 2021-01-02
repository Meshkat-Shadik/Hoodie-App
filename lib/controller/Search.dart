import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:xl_sheet_crud_test/Model/getDataForm.dart';
import 'package:xl_sheet_crud_test/Model/teacherForm.dart';

class Search extends SearchDelegate{
  
  final List<GetDataForm> studentList;
  final String currcat;
  Search(this.studentList,this.currcat);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
      Navigator.pop(context);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
//



  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? studentList:
    studentList.where((element){
      var x ;
      if(currcat=='Host')
        {
          x = element.host.toString().toLowerCase().contains(new RegExp(query, caseSensitive: false));
        }
      else if(currcat=='Size')
        {
          x = element.size.toString().toLowerCase().contains(new RegExp(query, caseSensitive: false));
        }
      else
        {
          x = element.name.toString().toLowerCase().contains(new RegExp(query, caseSensitive: false));
        }
      return x;
    }).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        // child:  DataTable(
        //
        //   columns: [
        //     //   DataColumn(label: Text('Delivered?')),
        //     DataColumn(label: Text('SN')),
        //     DataColumn(label: Text('Name')),
        //     DataColumn(label: Text('Class/Batch(SSC)')),
        //     DataColumn(label: Text('Size')),
        //     DataColumn(label: Text('phone')),
        //     DataColumn(label: Text('Hoodie Price')),
        //     DataColumn(label: Text('Payment Way')),
        //     DataColumn(label: Text('Pickup Cost')),
        //     DataColumn(label: Text('Method')),
        //     DataColumn(label: Text('Address')),
        //     DataColumn(label: Text('Host')),
        //
        //     //  DataColumn(label: Text('')),
        //     //
        //   ],
        //   rows:
        //   List<DataRow>.generate(
        //     suggestionList.length-1,
        //         (index) => DataRow(
        //       // color: feedbackItems[index].done!=''?Color(Colors.white):Colors.green,
        //       // color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        //       //   if (states.contains(MaterialState.selected))
        //       //     return Theme.of(context).colorScheme.primary.withOpacity(0.08);
        //       //   return null;  // Use the default value.
        //       // }
        //       //   color: MaterialStateColor.resolveWith((states) =>feedbackItems[index].done!=''?Theme.of(context).colorScheme.copyWith(primary: Colors.red).primary.withOpacity(0.5):Theme.of(context).colorScheme.copyWith(primary: Colors.transparent).primary),
        //       cells:<DataCell> [
        //         //      DataCell(feedbackItems[index].done!=''?Text(''):RaisedButton(child: Text('YES'),onPressed: feedbackItems[index].done!=''?null: ()async{ await http.post("https://script.google.com/macros/s/AKfycbwrdvDhJyVkwdl-EgB8g-adf0Lr9EVvNneKJuBGIex8lQ0UMxO3/exec?name=&batch=&size=&phone=&price=&paymentWay=&pickupCost=&method=&address=&host=&cat=S&done=${(feedbackItems.length-1-index).toString()}").then((response) {
        //         //Your stuff
        //
        //         //     setState(() {}); //refresh
        //         // Navigator.popAndPushNamed(context, '/');
        //         //     })
        //
        //         // ;},)),
        //         DataCell(Text((suggestionList.length-1-index).toString())),
        //         DataCell(Text(suggestionList[index].name)), //Extracting from Map element the value
        //         DataCell(Text(suggestionList[index].batch)),
        //         DataCell(Text(suggestionList[index].size)),
        //         DataCell(Text('0'+suggestionList[index].phone),onTap: (){launch("tel://"+'0'+suggestionList[index].phone);}), //Extracting from Map element the value
        //         DataCell(Text(suggestionList[index].price)),
        //         DataCell(Text(suggestionList[index].paymentWay)),
        //         DataCell(Text(suggestionList[index].pickupCost)), //Extracting from Map element the value
        //         DataCell(Text(suggestionList[index].method)),
        //         DataCell(Text(suggestionList[index].address)),
        //         DataCell(Text(suggestionList[index].host)),
        //       ],
        //
        //     ),
        //     //UrlLauncher.launch('tel:+${('0'+feedbackItems[index].phone).toString()}');
        //   ).toList(),
        //
        // ),




        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(32),
                    child: Text("TOTAL RESULTS = "+suggestionList.length.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),))
              ],
            ),
            DataTable(

              columns: [
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
              ],
              rows:
              // Loops through dataColumnText, each iteration assigning the value to element
              suggestionList.map(
                ((element) => DataRow(
                  cells: <DataCell>[
                   DataCell(Text(element.sn)),
                    DataCell(Text(element.name)), //Extracting from Map element the value
                    DataCell(Text(element.batch)),
                    DataCell(Text(element.size)),
                    DataCell(Text('0'+element.phone)), //Extracting from Map element the value
                    DataCell(Text(element.price)),
                    DataCell(Text(element.paymentWay)),
                    DataCell(Text(element.pickupCost)), //Extracting from Map element the value
                    DataCell(Text(element.method)),
                    DataCell(Text(element.address)),
                    DataCell(Text(element.host)), //Extracting from Map element the value
                    //    DataCell(Text(element.size)),
                  ],
                )),
              ) .toList(),
            ),
          ],
        ),
      ),
    );
        
  }
  
}