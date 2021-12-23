import 'package:flutter/material.dart';
import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:xl_sheet_crud_test/Model/teacherForm.dart';
import 'package:xl_sheet_crud_test/controller/form_controller.dart';
import 'package:xl_sheet_crud_test/controller/teacher_form_controller.dart';

class TeachersPage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> sizeList = ['M', 'L', 'XL', 'XXL'];
  final List<String> cashWay = ['cash', 'bkash', 'rocket', 'nagad'];
  final List<String> pickup = ['0', '40', '100'];
  final List<String> collectionWay = ['checkpoint', 'parcel'];
  final List<String> hosts = [
    'Faysal',
    'Dodul',
    'Naym',
    'Nafi',
    'Shakil',
    'Shadik'
  ];
  final List<String> sc = ['School', 'College'];
  final List<String> chain = [
    'Without Logo + Chain',
    'With Logo + Chain',
    'With Logo',
    'Without Logo'
  ];

  String currSize;
  String cashSelection;
  String pickupCost;
  String selectCollectionWay;
  String selectedHosts;
  String curSc;
  String curDesign;

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController logoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController paymentWayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController hostController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    FeedbackFormTeacher feedbackFormTeacher = FeedbackFormTeacher(
        nameController.text,
        // batchController.text,
        curSc,
        // sizeController.text,
        currSize,
        //  logoController.text,
        curDesign,
        phoneController.text,
        priceController.text,
        //  paymentWayController.text,
        cashSelection,
        addressController.text,
        // hostController.text,
        selectedHosts,
        'T');

    FormControllerTeacher formController = FormControllerTeacher();

    _showSnackbar("Submitting Order", 1);
    formController.submitForm(feedbackFormTeacher, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        _showSnackbar("Order Successful!", 2);
        cleaar();
      } else {
        // Error Occurred while saving data in Google Sheets.
        _showSnackbar("Error Occurred!", 0);
      }
    });
  }

  void cleaar() {
    nameController.clear();
    batchController.clear();
    logoController.clear();
    sizeController.clear();
    phoneController.clear();
    priceController.clear();
    paymentWayController.clear();
    addressController.clear();
    hostController.clear();
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message, int state) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: state == 1
          ? Colors.blue
          : state == 2
              ? Colors.green
              : Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      // TextFormField(
                      //   controller: batchController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: InputDecoration(
                      //       labelText: 'School/College (only S/C)'
                      //   ),
                      // ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.school),
                        hint: Text('School/College'),
                        dropdownColor: Colors.blueGrey,
                        items: sc.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            curSc = val;
                          });
                        },
                      ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.format_size),
                        hint: Text('Size'),
                        dropdownColor: Colors.blueGrey,
                        items: sizeList.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            currSize = val;
                          });
                        },
                      ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.style),
                        hint: Text('Style'),
                        dropdownColor: Colors.blueGrey,
                        items: chain.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            curDesign = val;
                          });
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Phone'),
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Hoodie Price'),
                      ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.money),
                        hint: Text('Payment Way'),
                        dropdownColor: Colors.blueGrey,
                        items: cashWay.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            cashSelection = val;
                          });
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.people),
                        hint: Text('Hosts'),
                        dropdownColor: Colors.blueGrey,
                        items: hosts.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedHosts = val;
                          });
                        },
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
