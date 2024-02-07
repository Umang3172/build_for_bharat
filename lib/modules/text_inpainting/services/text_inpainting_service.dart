import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class TextInpaintingService {
  static Future<Uint8List> postImage(final imageBytes, final maskBytes) async {
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

    request.fields['text_prompt'] = '"A woman with a yellow scarf"';

    final response = await request.send();
    final respBytes = await response.stream.toBytes();
    return respBytes;
  }
}
