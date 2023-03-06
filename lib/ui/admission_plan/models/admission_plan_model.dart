class AdmissionPlanModel {
  String? message;
  List<AdmssionPlanPayload>? payload;

  AdmissionPlanModel({this.message, this.payload});

  AdmissionPlanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <AdmssionPlanPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new AdmssionPlanPayload.fromJson(v));
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

class AdmssionPlanPayload {
  String? id;
  int? quotaStatus;
  String? quotaSpecificSubject;
  int? quotaQty;
  String? quotaDetail;
  int? directStatus;
  String? directSpecificSubject;
  String? directDetail;
  int? directQty;
  int? cooperationStatus;
  String? cooperationSpecificSubject;
  String? cooperationDetail;
  int? cooperationQty;
  int? year;
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

  AdmssionPlanPayload(
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

  AdmssionPlanPayload.fromJson(Map<String, dynamic> json) {
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
    data['Course.major'] = this.courseMajor;
    data['Course.degree'] = this.courseDegree;
    data['Course.detail'] = this.courseDetail;
    data['Course.faculty'] = this.courseFaculty;
    data['Course.created_at'] = this.courseCreatedAt;
    data['Course.updated_at'] = this.courseUpdatedAt;
    return data;
  }
}
