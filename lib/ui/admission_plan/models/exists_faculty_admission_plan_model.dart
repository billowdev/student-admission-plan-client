class ExistsFacultyAdmissionPlanModel {
  String? message;
  List<String>? payload;

  ExistsFacultyAdmissionPlanModel({this.message, this.payload});

  ExistsFacultyAdmissionPlanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['payload'] = this.payload;
    return data;
  }
}