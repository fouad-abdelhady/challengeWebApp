import 'package:dashboard/data/models/users_models.dart';
import '../local.dart';
import '../services/services.dart';

class AuthenticationRepo {
  final _registerStaffRoute = "registerStaff";
  final _loginRoute = "login";
  final _registerStudentRoute = "registerStudent";
  final _getUserDataRoute = "getUserData";
  final Services _services = Services();

  Future<LoginResponseModel> login(String userName, String password) async {
    var body = {"userName": userName, "password": password};
    var response = await _services.postRequest(route: _loginRoute, body: body);
    var loginResponseModel = LoginResponseModel.fromJson(response.data);
    if (loginResponseModel.accessToken != null) {
      await LocalData().saveToken(loginResponseModel.accessToken!);
      _services.token = loginResponseModel.accessToken;
    }
    return loginResponseModel;
  }

  Future<LoginResponseModel> getUserData() async {
    var response =
        await _services.postRequest(route: _getUserDataRoute, body: {});
    return LoginResponseModel.fromJson(response.data);
  }
}
