/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackFormTeacher {
  String name;
  String sc;
  String size;
  String logo;
  String phone;
  String price;
  String paymentWay;
  String address;
  String host;
  String cat;

  FeedbackFormTeacher(this.name, this.sc, this.size, this.logo,this.phone,this.price,this.paymentWay,this.address,this.host,this.cat);

  factory FeedbackFormTeacher.fromJson(dynamic json) {
    return FeedbackFormTeacher("${json['name']}", "${json['sc']}",
        "${json['size']}", "${json['logo']}", "${json['phone']}", "${json['price']}", "${json['paymentWay']}", "${json['address']}", "${json['host']}", "${json['cat']}" );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'sc': sc,
    'size': size,
    'logo':logo,
    'phone': phone,
    'price':price,
    'paymentWay':paymentWay,
    'address':address,
    'host':host,
    'cat':cat,
  };
}