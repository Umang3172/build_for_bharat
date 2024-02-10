import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class TextInpaintingService {
  static Future<Uint8List> postImage(
      final imageBytes, final maskBytes, String promptText) async {
    const apiKey =
        'e810e86a6a700ca0c11a56cd8da0199c956e871f40fe70ca54999e5812035d01a7a5c65b1d8c63c7a13870d4786138b7';

    final request = http.MultipartRequest(
        'POST', Uri.parse('https://clipdrop-api.co/text-inpainting/v1'));

    var imageFile = http.MultipartFile.fromBytes(
      'image_file',
      imageBytes,
      filename: 'image.jpg',
    );

    var maskFile = http.MultipartFile.fromBytes(
      'mask_file',
      maskBytes,
      filename: 'mask.jpg',
    );

    request.headers['x-api-key'] = apiKey;
    request.files.add(imageFile);
    request.files.add(maskFile);

    request.fields['text_prompt'] = promptText;

    final response = await request.send();
    final respBytes = await response.stream.toBytes();
    return respBytes;
  }

  static Future<Uint8List> textPromptToImage(String promptText) async {
    var apiKey =
        'b7b027ac772b4bdbe3f6673b44c00070511ba7d0a8c2d48339ff514225d676c39a9695ff18821f3d8db5e69c30b44ddc';
    var url = 'https://clipdrop-api.co/text-to-image/v1';
    var client = http.Client();

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['x-api-key'] = apiKey
      ..fields['prompt'] = promptText;

    var response = await client.send(request);

    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }

    var bytes = await response.stream.toBytes();
    return bytes;
  }
}
