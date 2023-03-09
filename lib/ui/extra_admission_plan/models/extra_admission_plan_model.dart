class ExtraAdmissionPlanModel {
  String? message;
  ExtraAdmissionPlanPayload? payload;

  ExtraAdmissionPlanModel({this.message, this.payload});

  ExtraAdmissionPlanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload =
        json['payload'] != null ? ExtraAdmissionPlanPayload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class ExtraAdmissionPlanPayload {
  String? id;
  int? qty;
  String? year;
  String? courseId;
  String? createdAt;
  String? updatedAt;


  ExtraAdmissionPlanPayload(
      {this.id,
      this.qty,
      this.year,
      this.createdAt,
      this.updatedAt,
      this.courseId});

  ExtraAdmissionPlanPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    year = json['year'];
    courseId = json['courseId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseId = json['CourseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['qty'] = qty;
    data['year'] = year;
    data['courseId'] = courseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['CourseId'] = courseId;
    return data;
  }
}
