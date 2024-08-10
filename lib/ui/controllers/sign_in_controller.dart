import 'package:get/get.dart';
import 'package:taskmanager/data/models/logIn_model.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/networkCaller/network_caller.dart';
import 'package:taskmanager/data/utilities/urls.dart';
import 'package:taskmanager/ui/controllers/auth_controlres.dart';

class SignInController extends GetxController {
  bool _signInApiInPrograss = false;
  String _errorMessage = '';

  bool get signInApiInPrograss => _signInApiInPrograss;
  String get errorMessage => _errorMessage;

  Future<bool> SignUP(String email, String password) async {
    bool isSuccess = false;

    _signInApiInPrograss = true;
    update();
    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    final NetworkResponse networkResponse =
        await NetworkCaller.postRequest(Urls.login, requestData);

    if (networkResponse.inSuccess) {
      LogInModel loginModel = LogInModel.fromJson(networkResponse.responseData);
      await AuthControler.saveUserAccessToken(loginModel.token!);
      await AuthControler.saveUserData(loginModel.userModel!);

      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage ?? 'Log in Failled';
    }
    _signInApiInPrograss = false;
    update();
    return isSuccess;
  }
}
