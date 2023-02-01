import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiServices {
  Future<String> upload(File imageFile, int age) async {
    var stream = http.ByteStream(DelegatingStream(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://eye-ai.herokuapp.com/upload/?age=$age");
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "multipart/form-data"
    };
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.body != null) {}
    return response.body;
  }
}
