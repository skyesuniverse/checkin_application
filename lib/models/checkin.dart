class CheckIn {
  String? checkinId;
  String? employeeId;
  String? checkinLat;
  String? checkinLong;
  String? checkinState;
  String? checkinLocality;
  String? checkinDate;
  String? checkinTime;

  CheckIn(
      {this.checkinId,
      this.employeeId,
      this.checkinLat,
      this.checkinLong,
      this.checkinState,
      this.checkinLocality,
      this.checkinDate,
      this.checkinTime});

  CheckIn.fromJson(Map<String, dynamic> json) {
    checkinId = json['check_id'];
    employeeId = json['employee_id'];
    checkinLat = json['checkin_lat'];
    checkinLong = json['checkin_long'];
    checkinState = json['checkin_state'];
    checkinLocality = json['checkin_locality'];
    checkinDate = json['checkin_date'];
    checkinTime = json['checkin_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['catch_id'] = checkinId;
    data['user_id'] = employeeId;
    data['checkin_lat'] = checkinLat;
    data['checkin_long'] = checkinLong;
    data['checkin_state'] = checkinState;
    data['checkin_locality'] = checkinLocality;
    data['checkin_date'] = checkinDate;
    data['checkin_time'] = checkinTime;
    return data;
  }
}
