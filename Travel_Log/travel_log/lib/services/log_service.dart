 import 'dart:io';



class LogService {
 static Future<File> _getLogFile() async {
   final dir = await getApplicationDocumentsDirectory();
   final filePath = '${dir.path}/location_log.txt';
   return File(filePath);
 }

  static Future<void> appendLog(String text) async {
    final file = await _getLogFile();
   final timestamp = DateTime.now().toIso8601String();
    await file.writeAsString('[$timestamp] $text\n', mode: FileMode.append);
  }

  static Future<List<String>> readLogs() async {
     final file = await _getLogFile();
    if (!await file.exists()) return [];
    final contents = await file.readAsLines();
    return contents;
 }
  
   static Future getApplicationDocumentsDirectory() async {}
 }
