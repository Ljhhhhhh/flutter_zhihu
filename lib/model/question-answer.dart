class QAModel {
  String message;
  int code;
  QAResult result;

  QAModel({this.message, this.code, this.result});

  QAModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    result =
        json['result'] != null ? new QAResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class QAResult {
  List<Topics> topics;
  String sId;
  String title;
  String description;
  Questioner questioner;
  String createdAt;
  String updatedAt;

  QAResult(
      {this.topics,
      this.sId,
      this.title,
      this.description,
      this.questioner,
      this.createdAt,
      this.updatedAt});

  QAResult.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    questioner = json['questioner'] != null
        ? new Questioner.fromJson(json['questioner'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.questioner != null) {
      data['questioner'] = this.questioner.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Topics {
  String sId;
  String name;
  String introduction;
  String createdAt;
  String updatedAt;

  Topics(
      {this.sId, this.name, this.introduction, this.createdAt, this.updatedAt});

  Topics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    introduction = json['introduction'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['introduction'] = this.introduction;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Questioner {
  String gender;
  String sId;
  String name;
  String createdAt;
  String updatedAt;

  Questioner(
      {this.gender, this.sId, this.name, this.createdAt, this.updatedAt});

  Questioner.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    sId = json['_id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
