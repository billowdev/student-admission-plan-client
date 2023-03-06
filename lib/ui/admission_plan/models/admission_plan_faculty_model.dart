class AdmssionPlanFacultyModel {
  String? message;
  List<AdmssionPlanFacultyPayload>? payload;

  AdmssionPlanFacultyModel({this.message, this.payload});

  AdmssionPlanFacultyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <AdmssionPlanFacultyPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new AdmssionPlanFacultyPayload.fromJson(v));
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

class AdmssionPlanFacultyPayload {
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
  int? year;
  int? studyGroup;
  String? courseId;
  String? createdAt;
  String? updatedAt;
  Course? course;

  AdmssionPlanFacultyPayload(
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

  AdmssionPlanFacultyPayload.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quotaStatus'] = this.quotaStatus;
    data['quotaSpecificSubject'] = this.quotaSpecificSubject;
    data['quotaQty'] = this.quotaQty;
    data['quotaDetail'] = this.quotaDetail;
    data['directStatus'] = this.directStatus;
    data['directSpecificSubject'] = this.directSpecificSubject;
    data['directDetail'] = this.directDetail;
    data['directQty'] = this.directQty;
    data['cooperationStatus'] = this.cooperationStatus;
    data['cooperationSpecificSubject'] = this.cooperationSpecificSubject;
    data['cooperationDetail'] = this.cooperationDetail;
    data['cooperationQty'] = this.cooperationQty;
    data['year'] = this.year;
    data['studyGroup'] = this.studyGroup;
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
