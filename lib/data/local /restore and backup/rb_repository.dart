import 'package:permission_handler/permission_handler.dart';

class RestoreAndBackupLocal {
  Future<void> backupDatabase() async {
    var status = await Permission.manageExternalStorage.status;
    if(!status.isGranted){
      await Permission.manageExternalStorage.request();
    } 

    var status1 = await Permission.storage.status;
  }

  Future<void> restoreDatabase() async {
  }
}
