class AdmssionPlanFacultyModel {
  String? message;
  List<AdmissionPlanFacultyPayload>? payload;

  AdmssionPlanFacultyModel({this.message, this.payload});

  AdmssionPlanFacultyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <AdmissionPlanFacultyPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new AdmissionPlanFacultyPayload.fromJson(v));
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

class AdmissionPlanFacultyPayload {
  String? id;
  bool? quotaStatus;
  String? quotaSpecificSubject;
  int? quotaQty;
  String? quotaDetail;
  bool? directStatus;
  String? directSpecificSubject;
  String? directDetail;
  int? directQty;
  bool? cooperationStatus;
  String? cooperationSpecificSubject;
  String? cooperationDetail;
  int? cooperationQty;
  String? year;
  int? studyGroup;
  String? courseId;
  String? createdAt;
  String? updatedAt;
  Course? course;

  AdmissionPlanFacultyPayload(
      {this.id,
      this.quotaStatus,
      this.quotaSpecificSubject,
      this.quotaQty,
      this.quotaDetail,
      this.directStatus,
      this.directSpecificSubject,
      this.directDetail,
      this.directQty,
      this.cooperationStatus,
      this.cooperationSpecificSubject,
      this.cooperationDetail,
      this.cooperationQty,
      this.year,
      this.studyGroup,
      this.courseId,
      this.createdAt,
      this.updatedAt,
      this.course});

  AdmissionPlanFacultyPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quotaStatus = json['quotaStatus'];
    quotaSpecificSubject = json['quotaSpecificSubject'];
    quotaQty = json['quotaQty'];
    quotaDetail = json['quotaDetail'];
    directStatus = json['directStatus'];
    directSpecificSubject = json['directSpecificSubject'];
    directDetail = json['directDetail'];
    directQty = json['directQty'];
    cooperationStatus = json['cooperationStatus'];
    cooperationSpecificSubject = json['cooperationSpecificSubject'];
    cooperationDetail = json['cooperationDetail'];
    cooperationQty = json['cooperationQty'];
    year = json['year'];
    studyGroup = json['studyGroup'];
    courseId = json['courseId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseId = json['CourseId'];
    course =
        json['Course'] != null ? new Course.fromJson(json['Course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quotaStatus'] = quotaStatus;
    data['quotaSpecificSubject'] = quotaSpecificSubject;
    data['quotaQty'] = quotaQty;
    data['quotaDetail'] = quotaDetail;
    data['directStatus'] = directStatus;
    data['directSpecificSubject'] = directSpecificSubject;
    data['directDetail'] = directDetail;
    data['directQty'] = directQty;
    data['cooperationStatus'] = cooperationStatus;
    data['cooperationSpecificSubject'] = cooperationSpecificSubject;
    data['cooperationDetail'] = cooperationDetail;
    data['cooperationQty'] = cooperationQty;
    data['year'] = year;
    data['studyGroup'] = studyGroup;
    data['courseId'] = courseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['CourseId'] = courseId;
    if (course != null) {
      data['Course'] = course!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['major'] = major;
    data['degree'] = degree;
    data['detail'] = detail;
    data['faculty'] = faculty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
