class AnswerResModel {
  String message;
  int code;
  List<AnswerModel> result;

  AnswerResModel({this.message, this.code, this.result});

  AnswerResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['result'] != null) {
      result = new List<AnswerModel>();
      json['result'].forEach((v) {
        result.add(new AnswerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerModel {
  int voteCount;
  String sId;
  String content;
  String questionId;
  String createdAt;
  String updatedAt;

  AnswerModel(
      {this.voteCount,
      this.sId,
      this.content,
      this.questionId,
      this.createdAt,
      this.updatedAt});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    voteCount = json['voteCount'];
    sId = json['_id'];
    content = json['content'];
    questionId = json['questionId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voteCount'] = this.voteCount;
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['questionId'] = this.questionId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
