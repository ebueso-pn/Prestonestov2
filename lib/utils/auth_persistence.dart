import 'package:shared_preferences/shared_preferences.dart';

Future<bool> hasLoggedInBefore() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') != null;
}
