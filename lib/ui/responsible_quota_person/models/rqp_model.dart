class RQPModel {
  String? message;
  RQPPayload? payload;

  RQPModel({this.message, this.payload});

  RQPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'] != null
        ? RQPPayload.fromJson(json['payload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class RQPPayload {
  String? id;
  String? year;
  String? name;
  String? surname;
  String? agency;
  String? phone;
  String? quota;
  String? createdAt;
  String? updatedAt;

  RQPPayload(
      {this.id,
      this.year,
      this.name,
      this.surname,
      this.agency,
      this.phone,
      this.quota,
      this.createdAt,
      this.updatedAt});

  RQPPayload.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
