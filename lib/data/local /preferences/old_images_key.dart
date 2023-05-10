import 'package:shared_preferences/shared_preferences.dart';

class OldImagesPrefService {
  late final SharedPreferences _shared;
  void openShared() async {
    _shared = await SharedPreferences.getInstance();
  }

  Future<bool> saveOldImages(List<String> images) async {
    print("Saving old images");
    return await _shared.setStringList('old_images', images);
  }

  Future<List<String>?> get oldImages async =>
      await _shared.getStringList('old_images');

  Future<bool> get removeAllOldImages => _shared.remove('old_images');

  
}
