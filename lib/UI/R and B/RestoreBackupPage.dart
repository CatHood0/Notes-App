import 'package:flutter/material.dart';
import 'package:notes_project/data/local%20/restore%20and%20backup/rb_repository.dart';

class RestoreBackupPage extends StatelessWidget {
  const RestoreBackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: () async {
          RestoreAndBackupLocal backup = RestoreAndBackupLocal();
          await backup.backupDatabase();
        },
        child: Text("Backup"),
      )),
    );
  }
}
