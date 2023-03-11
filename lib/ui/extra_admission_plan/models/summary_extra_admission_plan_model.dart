class ExtraAdmissionPlan {
  String id;
  int qty;
  String year;
  String courseId;
  DateTime createdAt;
  DateTime updatedAt;
  Course course;

  ExtraAdmissionPlan({
    required this.id,
    required this.qty,
    required this.year,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
  });

  factory ExtraAdmissionPlan.fromJson(Map<String, dynamic> json) {
    return ExtraAdmissionPlan(
      id: json['id'],
      qty: json['qty'],
      year: json['year'],
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

// class ExtraAdmissionPlanResponse {
//   List<ExtraAdmissionPlan> extraAdmissionPlans;
  
//   ExtraAdmissionPlanResponse({required this.extraAdmissionPlans});
  
//   factory ExtraAdmissionPlanResponse.fromJson(Map<String, dynamic> json) {
//     List<ExtraAdmissionPlan> extraAdmissionPlans = List.from(json['extraAdmissionPlans']).map((plan) => ExtraAdmissionPlan.fromJson(plan)).toList();
//     return ExtraAdmissionPlanResponse(extraAdmissionPlans: extraAdmissionPlans);
//   }
// }


class ExtraAdmissionPlanResponse {
  String message;
  Map<String, List<ExtraAdmissionPlan>> payload;

  ExtraAdmissionPlanResponse({
    required this.message,
    required this.payload,
  });

  factory ExtraAdmissionPlanResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, List<ExtraAdmissionPlan>> payload = Map.fromEntries(
      json['payload'].entries.map(
            (entry) => MapEntry(
              entry.key,
              List<ExtraAdmissionPlan>.from(
                entry.value.map((item) => ExtraAdmissionPlan.fromJson(item)),
              ),
            ),
          ),
    );

    return ExtraAdmissionPlanResponse(
      message: json['message'],
      payload: payload,
    );
  }
}

class ExtraAdmissionPlanGroupByFacultyPayload {
  Map<String, List<ExtraAdmissionPlan>> payload;

  ExtraAdmissionPlanGroupByFacultyPayload({required this.payload});

  factory ExtraAdmissionPlanGroupByFacultyPayload.fromJson(
      Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    final groupedPayload = <String, List<ExtraAdmissionPlan>>{};
    payload.forEach((key, value) {
      final plans = List<ExtraAdmissionPlan>.from(
          value.map((plan) => ExtraAdmissionPlan.fromJson(plan)));
      groupedPayload[key] = plans;
    });
    return ExtraAdmissionPlanGroupByFacultyPayload(payload: groupedPayload);
  }
}
