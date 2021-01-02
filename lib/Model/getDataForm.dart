/// FeedbackForm is a data class which stores data fields of Feedback.
class GetDataForm {
  String name;
  String batch;
  String size;
  String phone;
  String price;
  String paymentWay;
  String pickupCost;
  String method;
  String address;
  String host;
  String cat;
  //String currcat;
  String done;
  String sn;
  String logo;
  GetDataForm(this.sn,this.name, this.batch, this.size, this.phone,this.price,this.paymentWay,this.pickupCost,this.method,this.address,this.host,this.cat,this.done);
  //FeedbackForm.setMyCons(this.currcat);



  factory GetDataForm.fromJson(dynamic json) {
    return GetDataForm("${json['sn']}","${json['name']}", "${json['batch']}",
        "${json['size']}", "${json['phone']}", "${json['price']}", "${json['paymentWay']}", "${json['pickupCost']}", "${json['method']}", "${json['address']}", "${json['host']}", "${json['cat']}", "${json['done']}" );
  }

  // Method to make GET parameters.
  Map toJson() => {
     'sn':sn,
    'name': name,
    'batch': batch,
    'size': size,
    'phone': phone,
    'price':price,
    'paymentWay':paymentWay,
    'pickupCost':pickupCost,
    'method':method,
    'address':address,
    'host':host,
    'cat':cat,
    'done':done,
  };
}