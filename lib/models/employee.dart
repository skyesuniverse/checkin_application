class Employee {
  String? id;
  String? email;
  String? name;
  String? dept;
  String? phone;
  String? password;
  String? otp;
  String? datereg;

  Employee(
      {this.id,
      this.email,
      this.name,
      this.dept,
      this.phone,
      this.password,
      this.otp,
      this.datereg});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    dept = json['dept'];
    phone = json['phone'];
    password = json['password'];
    otp = json['otp'];
    datereg = json['datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['dept'] = dept;
    data['phone'] = phone;
    data['password'] = password;
    data['otp'] = otp;
    data['datereg'] = datereg;
    return data;
  }
}
