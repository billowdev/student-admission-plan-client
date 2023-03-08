class AdmissionPlanModel {
  String? message;
  List<AdmissionPlanPayload>? payload;

  AdmissionPlanModel({this.message, this.payload});

  AdmissionPlanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <AdmissionPlanPayload>[];
      json['payload'].forEach((v) {
        payload!.add(AdmissionPlanPayload.fromJson(v));
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

class AdmissionPlanPayload {
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
  String? createdAt;
  String? updatedAt;
  String? courseId;
  String? courseMajor;
  String? courseDegree;
  String? courseDetail;
  String? courseFaculty;
  String? courseCreatedAt;
  String? courseUpdatedAt;

  AdmissionPlanPayload(
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
      this.courseMajor,
      this.courseDegree,
      this.courseDetail,
      this.courseFaculty,
      this.courseCreatedAt,
      this.courseUpdatedAt});

  AdmissionPlanPayload.fromJson(Map<String, dynamic> json) {
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
    courseMajor = json['Course.major'];
    courseDegree = json['Course.degree'];
    courseDetail = json['Course.detail'];
    courseFaculty = json['Course.faculty'];
    courseCreatedAt = json['Course.created_at'];
    courseUpdatedAt = json['Course.updated_at'];
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
    data['Course.major'] = courseMajor;
    data['Course.degree'] = courseDegree;
    data['Course.detail'] = courseDetail;
    data['Course.faculty'] = courseFaculty;
    data['Course.created_at'] = courseCreatedAt;
    data['Course.updated_at'] = courseUpdatedAt;
    return data;
  }
}
