class ExistsFacultyExtraAdmissionPlan {
  String? message;
  List<String>? payload;

  ExistsFacultyExtraAdmissionPlan({this.message, this.payload});

  ExistsFacultyExtraAdmissionPlan.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['payload'] = payload;
    return data;
  }
}
