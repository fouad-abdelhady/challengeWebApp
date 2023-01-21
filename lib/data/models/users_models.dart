class LoginResponseModel {
  int? statusCode;
  String? accessToken;
  String? role;
  Instructor? instructor;
  Student? student;

  LoginResponseModel({this.statusCode, this.accessToken, this.instructor});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    accessToken = json['accessToken'];
    role = json['role'];
    if (role == null) return;
    if (role == "1") {
      instructor =
          json['user'] != null ? Instructor.fromJson(json['user']) : null;
    } else {
      student = json['user'] != null ? Student.fromJson(json['user']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['accessToken'] = accessToken;
    if (instructor != null) {
      data['user'] = instructor!.toJson();
    }
    return data;
  }
}

class Instructor {
  String? sId;
  String? firstName;
  String? lastName;
  String? title;
  List<String>? subjects;
  int? role;
  String? profileImage;
  String? refreshToken;
  String? accessToken;

  Instructor(
      {this.sId,
      this.firstName,
      this.lastName,
      this.title,
      this.subjects,
      this.role,
      this.profileImage,
      this.refreshToken});

  Instructor.fromJson(Map<String, dynamic> json, {this.accessToken}) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    title = json['title'];
    subjects = json['subjects'].cast<String>();
    role = json['role'];
    profileImage = json['profileImage'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['title'] = title;
    data['subjects'] = subjects;
    data['role'] = role;
    data['profileImage'] = profileImage;
    data['refreshToken'] = refreshToken;
    data['accessToken'] = accessToken;
    return data;
  }
}

class Student {
  String? sId;
  String? name;
  String? profileImage;
  String? refreshToken;
  String? subjectsTags;
  String? classId;

  Student(
      {this.sId,
      this.name,
      this.profileImage,
      this.refreshToken,
      this.subjectsTags,
      this.classId});

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    refreshToken = json['refreshToken'];
    subjectsTags = json['subjectsTags'];
    classId = json['classId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['refreshToken'] = refreshToken;
    data['subjectsTags'] = subjectsTags;
    data['classId'] = classId;
    return data;
  }
}
