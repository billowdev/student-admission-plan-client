class CourseModel {
  String? message;
  List<CoursePayload>? payload;

  CourseModel({this.message, this.payload});

  CourseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <CoursePayload>[];
      json['payload'].forEach((v) {
        payload!.add(new CoursePayload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoursePayload {
  String? id;
  String? major;
  String? degree;
  String? qualification;
  String? faculty;
  String? createdAt;
  String? updatedAt;

  CoursePayload(
      {this.id,
      this.major,
      this.degree,
      this.qualification,
      this.faculty,
      this.createdAt,
      this.updatedAt});

  CoursePayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    major = json['major'];
    degree = json['degree'];
    qualification = json['qualification'];
    faculty = json['faculty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['major'] = this.major;
    data['degree'] = this.degree;
    data['qualification'] = this.qualification;
    data['faculty'] = this.faculty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
