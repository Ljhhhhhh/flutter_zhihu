class QuestionModel {
  String message;
  int code;
  QuestionResult result;

  QuestionModel({this.message, this.code, this.result});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    result =
        json['result'] != null ? new QuestionResult.fromJson(json['result']) : null;
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

class QuestionResult {
  int total;
  List<QuestionItem> records;

  QuestionResult({this.total, this.records});

  QuestionResult.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['records'] != null) {
      records = new List<QuestionItem>();
      json['records'].forEach((v) {
        records.add(new QuestionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionItem {
  String sId;
  String title;
  String description;
  String createdAt;
  String updatedAt;

  QuestionItem(
      {this.sId, this.title, this.description, this.createdAt, this.updatedAt});

  QuestionItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
