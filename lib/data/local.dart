import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final LocalData _localData = LocalData._internal();
  factory LocalData() => _localData;
  final _tokenKey = "Token";
  SharedPreferences? _storage;
  LocalData._internal();
  Future init() async {
    _storage = await SharedPreferences.getInstance();
  }

  ///** for stay loggedin */
  Future saveToken(String token) async {
    await _storage!.setString(_tokenKey, token);
  }

  ///** for log out */
  Future<bool> deleteToken() async {
    bool done = true;
    await _storage!.remove(_tokenKey).catchError((err) {
      done = false;
    });
    return done;
  }

  ///** to check if the user is still logged in */
  Future<String?> isUserLogeIn() async => await _storage!.getString(_tokenKey);
}
