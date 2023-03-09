class ResponsibleQuotaPersonModel {
  String? message;
  List<ResponsibleQuotaPersonPayload>? payload;

  ResponsibleQuotaPersonModel({this.message, this.payload});

  ResponsibleQuotaPersonModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <ResponsibleQuotaPersonPayload>[];
      json['payload'].forEach((v) {
        payload!.add(ResponsibleQuotaPersonPayload.fromJson(v));
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

class ResponsibleQuotaPersonPayload {
  String? id;
  String? year;
  String? name;
  String? surname;
  String? agency;
  String? phone;
  String? quota;
  String? createdAt;
  String? updatedAt;

  ResponsibleQuotaPersonPayload(
      {this.id,
      this.year,
      this.name,
      this.surname,
      this.agency,
      this.phone,
      this.quota,
      this.createdAt,
      this.updatedAt});

  ResponsibleQuotaPersonPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    name = json['name'];
    surname = json['surname'];
    agency = json['agency'];
    phone = json['phone'];
    quota = json['quota'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['year'] = year;
    data['name'] = name;
    data['surname'] = surname;
    data['agency'] = agency;
    data['phone'] = phone;
    data['quota'] = quota;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
