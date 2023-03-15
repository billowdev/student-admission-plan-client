class UserArrayModel {
  String? message;
  List<UserPayload>? payload;

  UserArrayModel({this.message, this.payload});

  UserArrayModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <UserPayload>[];
      json['payload'].forEach((v) {
        payload!.add(UserPayload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPayload {
  String? id;
  String? username;
  String? email;
  String? name;
  String? surname;
  String? phone;
  String? role;
  String? faculty;
  String? createdAt;
  String? updatedAt;

  UserPayload(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.surname,
      this.phone,
      this.role,
      this.faculty,
      this.createdAt,
      this.updatedAt});

  UserPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    role = json['role'];
    faculty = json['faculty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['phone'] = phone;
    data['role'] = role;
    data['faculty'] = faculty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserModel {
  String? message;
  UserPayload? payload;

  UserModel({this.message, this.payload});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'] != null
        ? new UserPayload.fromJson(json['payload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}
