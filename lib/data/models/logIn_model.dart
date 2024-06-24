import 'package:taskmanager/data/models/user_data_model.dart';

class LogInModel {
  String? status;
  String? token;
  UserModel? userModel;

  LogInModel({this.status, this.token, this.userModel});

  LogInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }
    return data;
  }
}
