import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xl_sheet_crud_test/Model/form.dart';
import 'package:xl_sheet_crud_test/controller/form_controller.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> sizeList = ['M', 'L', 'XL', 'XXL'];
  final List<String> cashWay = ['cash', 'bkash', 'nagad'];
  final List<String> pickup = ['0', '40', '100'];
  final List<String> collectionWay = ['checkpoint', 'parcel'];
  final List<String> hosts = ['Faysal', 'Anik', 'Siam'];
  String currSize;
  String cashSelection;
  String pickupCost;
  String selectCollectionWay;
  String selectedHosts;

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController paymentWayController = TextEditingController();
  TextEditingController pickupCostController = TextEditingController();
  TextEditingController methodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController hostController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        batchController.text,
        // sizeController.text,
        currSize,
        phoneController.text,
        priceController.text,
        //  paymentWayController.text,
        cashSelection,
        //  pickupCostController.text,
        pickupCost,
        //   methodController.text,
        selectCollectionWay,
        addressController.text,
        //  hostController.text,
        selectedHosts,
        'S',
        '');

//http.post('https://script.google.com/macros/s/AKfycbw2CPx5KLSN-E94u06hf1xReW4Cg6l9a14Gr5_Yx5t6s-KrLSY/exec?&name=&batch=dsa&size=dsas&phone=dsa&price=dsad&paymentWay=sdad&pickupCost=dsa&method=dsa&address=sdas&host=dsadas&cat=S)

    FormController formController = FormController();

    _showSnackbar("Submitting Order", 1);
    formController.submitForm(feedbackForm, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        _showSnackbar("Order Submitted", 2);
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
    sizeController.clear();
    phoneController.clear();
    priceController.clear();
    paymentWayController.clear();
    pickupCostController.clear();
    methodController.clear();
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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,

      // resizeToAvoidBottomPadding: false,
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
                      TextFormField(
                        controller: batchController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Batch(SSC)'),
                      ),
                      // TextFormField(
                      //   controller: sizeController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Size(M/L/XL/XXL)',
                      //   ),
                      // ),

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
                      // TextFormField(
                      //   controller: paymentWayController,
                      //   keyboardType: TextInputType.multiline,
                      //   decoration: InputDecoration(
                      //       labelText: 'Payment Way (cash/bkash/nagad/rocket)'
                      //   ),
                      // ),
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
                      DropdownButtonFormField(
                        icon: Icon(CupertinoIcons.money_dollar),
                        hint: Text('Pickup Cost'),
                        dropdownColor: Colors.blueGrey,
                        items: pickup.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            pickupCost = val;
                          });
                        },
                      ),
                      DropdownButtonFormField(
                        icon: Icon(Icons.shopping_cart),
                        hint: Text('Delivery From'),
                        dropdownColor: Colors.blueGrey,
                        items: collectionWay.map((ele) {
                          return DropdownMenuItem(child: Text(ele), value: ele);
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectCollectionWay = val;
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
