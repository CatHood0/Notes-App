import 'package:shared_preferences/shared_preferences.dart';

class ConfigurerPreferences {
  late SharedPreferences shared;

  Future<void> SaveBasicSettings(Map<String, dynamic> settings) async {
    shared = await SharedPreferences.getInstance();
    shared.setString('theme', settings['theme']);
    shared.setString('font', settings['font']);
  }

  Future<Map<String, dynamic>> getPreferences(Map<String, String> key) async {
    shared = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {
      'theme': shared.getString(key['theme']!),
      'font': shared.getString(key['font']!),
    };
    return map;
  }
}
