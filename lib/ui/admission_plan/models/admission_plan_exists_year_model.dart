class AdmssionPlanExistsYear {
  String? message;
  List<int>? payload;

  AdmssionPlanExistsYear({this.message, this.payload});

  AdmssionPlanExistsYear.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['payload'] = payload;
    return data;
  }
}