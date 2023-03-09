class ExtraAdmissionPlanArray {
  String? message;
  List<ExtraAdmissionPlanArrayPayload>? payload;

  ExtraAdmissionPlanArray({this.message, this.payload});

  ExtraAdmissionPlanArray.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <ExtraAdmissionPlanArrayPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new ExtraAdmissionPlanArrayPayload.fromJson(v));
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

class ExtraAdmissionPlanArrayPayload {
  String? id;
  int? qty;
  String? year;
  String? courseId;
  String? createdAt;
  String? updatedAt;
  Course? course;

  ExtraAdmissionPlanArrayPayload(
      {this.id,
      this.qty,
      this.year,
      this.courseId,
      this.createdAt,
      this.updatedAt,
      this.course});

  ExtraAdmissionPlanArrayPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    year = json['year'];
    courseId = json['courseId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseId = json['CourseId'];
    course =
        json['Course'] != null ? new Course.fromJson(json['Course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['year'] = this.year;
    data['courseId'] = this.courseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['CourseId'] = this.courseId;
    if (this.course != null) {
      data['Course'] = this.course!.toJson();
    }
    return data;
  }
}

class Course {
  String? major;
  String? degree;
  String? detail;
  String? faculty;
  String? createdAt;
  String? updatedAt;

  Course(
      {this.major,
      this.degree,
      this.detail,
      this.faculty,
      this.createdAt,
      this.updatedAt});

  Course.fromJson(Map<String, dynamic> json) {
    major = json['major'];
    degree = json['degree'];
    detail = json['detail'];
    faculty = json['faculty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['major'] = this.major;
    data['degree'] = this.degree;
    data['detail'] = this.detail;
    data['faculty'] = this.faculty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
