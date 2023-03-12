class GroupByFacultyAdmissionPlan {
  String? id;
  bool? quotaStatus;
  String? quotaSpecificSubject;
  int? quotaGoodStudyQty;
  int? quotaGoodPersonQty;
  int? quotaGoodActivityIMQty;
  int? quotaGoodActivityLIQty;
  int? quotaGoodActivitySDDQty;
  int? quotaGoodSportQty;

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
  DateTime? createdAt;
  DateTime? updatedAt;
  Course? course;

  GroupByFacultyAdmissionPlan({
    this.id,
    this.quotaStatus,
    this.quotaSpecificSubject,
    this.quotaDetail,
    this.quotaGoodStudyQty,
    this.quotaGoodPersonQty,
    this.quotaGoodActivityIMQty,
    this.quotaGoodActivityLIQty,
    this.quotaGoodActivitySDDQty,
    this.quotaGoodSportQty,
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
    required this.course,
  });

  factory GroupByFacultyAdmissionPlan.fromJson(Map<String, dynamic> json) {
    return GroupByFacultyAdmissionPlan(
      id: json['id'],
      quotaStatus: json['quotaStatus'],
      quotaSpecificSubject: json['quotaSpecificSubject'],
      quotaGoodStudyQty: json['quotaGoodStudyQty'],
      quotaGoodPersonQty: json['quotaGoodPersonQty'],
      quotaGoodActivityIMQty: json['quotaGoodActivityIMQty'],
      quotaGoodActivityLIQty: json['quotaGoodActivityLIQty'],
      quotaGoodActivitySDDQty: json['quotaGoodActivitySDDQty'],
      quotaGoodSportQty: json['quotaGoodSportQty'],
      quotaDetail: json['quotaDetail'],
      directStatus: json['directStatus'],
      directSpecificSubject: json['directSpecificSubject'],
      directDetail: json['directDetail'],
      directQty: json['directQty'],
      cooperationStatus: json['cooperationStatus'],
      cooperationSpecificSubject: json['cooperationSpecificSubject'],
      cooperationDetail: json['cooperationDetail'],
      cooperationQty: json['cooperationQty'],
      year: json['year'],
      studyGroup: json['studyGroup'],
      courseId: json['courseId'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      course: Course.fromJson(json['Course']),
    );
  }
}

class Course {
  String major;
  String degree;
  String detail;
  String faculty;
  DateTime createdAt;
  DateTime updatedAt;

  Course({
    required this.major,
    required this.degree,
    required this.detail,
    required this.faculty,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      major: json['major'],
      degree: json['degree'],
      detail: json['detail'],
      faculty: json['faculty'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class GroupByFacultyAdmissionPlanResponse {
  String message;
  Map<String, List<GroupByFacultyAdmissionPlan>> payload;

  GroupByFacultyAdmissionPlanResponse({
    required this.message,
    required this.payload,
  });

  factory GroupByFacultyAdmissionPlanResponse.fromJson(
      Map<String, dynamic> json) {
    final Map<String, List<GroupByFacultyAdmissionPlan>> payload =
        Map.fromEntries(
      json['payload'].entries.map(
            (entry) => MapEntry(
              entry.key,
              List<GroupByFacultyAdmissionPlan>.from(
                entry.value
                    .map((item) => GroupByFacultyAdmissionPlan.fromJson(item)),
              ),
            ),
          ),
    );

    return GroupByFacultyAdmissionPlanResponse(
      message: json['message'],
      payload: payload,
    );
  }
}

class AdmissionPlanGroupByFacultyPayload {
  Map<String, List<GroupByFacultyAdmissionPlan>> payload;

  AdmissionPlanGroupByFacultyPayload({required this.payload});

  factory AdmissionPlanGroupByFacultyPayload.fromJson(
      Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    final groupedPayload = <String, List<GroupByFacultyAdmissionPlan>>{};
    payload.forEach((key, value) {
      final plans = List<GroupByFacultyAdmissionPlan>.from(
          value.map((plan) => GroupByFacultyAdmissionPlan.fromJson(plan)));
      groupedPayload[key] = plans;
    });
    return AdmissionPlanGroupByFacultyPayload(payload: groupedPayload);
  }
}
