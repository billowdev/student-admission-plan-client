class AdmissionPlan {
  String id;
  bool quotaStatus;
  String quotaSpecificSubject;
  int quotaGoodStudyQty;
  int quotaGoodPersonQty;
  int quotaGoodActivityIMQty;
  int quotaGoodActivityLIQty;
  int quotaGoodActivitySDDQty;
  int quotaGoodSportQty;
  String quotaDetail;
  bool directStatus;
  String directSpecificSubject;
  String directDetail;
  int directQty;
  bool cooperationStatus;
  String cooperationSpecificSubject;
  String cooperationDetail;
  int cooperationQty;
  String year;
  int studyGroup;
  String courseId;
  DateTime createdAt;
  DateTime updatedAt;
  Course course;

  AdmissionPlan({
    required this.id,
    required this.quotaStatus,
    required this.quotaSpecificSubject,
    required this.quotaGoodStudyQty,
    required this.quotaGoodPersonQty,
    required this.quotaGoodActivityIMQty,
    required this.quotaGoodActivityLIQty,
    required this.quotaGoodActivitySDDQty,
    required this.quotaGoodSportQty,
    required this.quotaDetail,
    required this.directStatus,
    required this.directSpecificSubject,
    required this.directDetail,
    required this.directQty,
    required this.cooperationStatus,
    required this.cooperationSpecificSubject,
    required this.cooperationDetail,
    required this.cooperationQty,
    required this.year,
    required this.studyGroup,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
  });

  factory AdmissionPlan.fromJson(Map<String, dynamic> json) {
    return AdmissionPlan(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// class AdmissionPlanGroupByFaculty {
//   Map<String, List<AdmissionPlan>> plansByFaculty = {};

//   AdmissionPlanGroupByFaculty(List<AdmissionPlan> plans) {
//     for (AdmissionPlan plan in plans) {
//       String faculty = plan.course.faculty;
//       if (!plansByFaculty.containsKey(faculty)) {
//         plansByFaculty[faculty] = [];
//       }
//       plansByFaculty[faculty]!.add(plan);
//     }
//   }
// }
class AdmissionPlanResponse {
  String message;
  Map<String, List<AdmissionPlan>> payload;

  AdmissionPlanResponse({
    required this.message,
    required this.payload,
  });

  factory AdmissionPlanResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, List<AdmissionPlan>> payload = Map.fromEntries(
      json['payload'].entries.map(
            (entry) => MapEntry(
              entry.key,
              List<AdmissionPlan>.from(
                entry.value.map((item) => AdmissionPlan.fromJson(item)),
              ),
            ),
          ),
    );

    return AdmissionPlanResponse(
      message: json['message'],
      payload: payload,
    );
  }
}

class AdmissionPlanGroupByFacultyPayload {
  Map<String, List<AdmissionPlan>> payload;

  AdmissionPlanGroupByFacultyPayload({required this.payload});

  factory AdmissionPlanGroupByFacultyPayload.fromJson(
      Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    final groupedPayload = <String, List<AdmissionPlan>>{};
    payload.forEach((key, value) {
      final plans = List<AdmissionPlan>.from(
          value.map((plan) => AdmissionPlan.fromJson(plan)));
      groupedPayload[key] = plans;
    });
    return AdmissionPlanGroupByFacultyPayload(payload: groupedPayload);
  }
}
