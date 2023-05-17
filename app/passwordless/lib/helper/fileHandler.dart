import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    return filePath;
  }

  void saveFile(String data) async {
    File file = File(await getFilePath()); // 1
    file.writeAsString(data); // 2
  }

  Future<String> readFile() async {
    File file = File(await getFilePath()); // 1
    String fileContent = await file.readAsString(); // 2
    return fileContent;
  }

  // Future<void> writeToFile(String data) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/data.txt');
  //   await file.writeAsString(data);
  // }

  // Future<String> readFromFile() async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final file = File('${directory.path}/data.txt');
  //     return await file.readAsString();
  //   } catch (e) {
  //     return '';
  //   }
  // }
}
