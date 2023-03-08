class CourseModel {
  String? message;
  List<CoursePayload>? payload;

  CourseModel({this.message, this.payload});

  CourseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <CoursePayload>[];
      json['payload'].forEach((v) {
        payload!.add(CoursePayload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoursePayload {
  String? id;
  String? major;
  String? degree;
  String? detail;
  String? faculty;
  String? createdAt;
  String? updatedAt;

  CoursePayload(
      {this.id,
      this.major,
      this.degree,
      this.detail,
      this.faculty,
      this.createdAt,
      this.updatedAt});

  CoursePayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    major = json['major'];
    degree = json['degree'];
    detail = json['detail'];
    faculty = json['faculty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['major'] = major;
    data['degree'] = degree;
    data['detail'] = detail;
    data['faculty'] = faculty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
