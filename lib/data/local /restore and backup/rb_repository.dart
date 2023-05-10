import 'package:permission_handler/permission_handler.dart';

class RestoreAndBackupLocal {
  Future<void> backupDatabase() async {
    var status = await Permission.manageExternalStorage.status;
    if(!status.isGranted){
      await Permission.manageExternalStorage.request();
    } 

  }

  Future<void> restoreDatabase() async {
  }
}
