import 'dart:convert';

import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:build_for_bharat/utils/secrets/secrets.dart';
import 'package:build_for_bharat/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OpenAIService {
  Secret secret = Secret();
  final List<Map<String, String>> messages = [];
  static const apiUri = Secret.api_url;
  static const apiKey = Secret.api_key;

  // Use productProvider to call the function and update the list.
  // Example: productProvider.updateList(tags);

  Future<Map<String, String>> chatGPTAPI(String prompt, bool isStart) async {
    // return "Yes";
    if (isStart) {
      prompt = Strings.rules;
    }
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      final res = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $apiKey',
          'OpenAI-Organization': ''
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
          "temperature": 0.7
        }),
      );

      //print(res.body);

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        // print('content ${content}');
        var result1 = extractJson(content);
        // print('result1 ${result1['remaining']}');
        // print('result1 ${result1['json']}');
        messages.add({
          'role': 'assistant',
          'content': result1['remaining']!,
        });

        return {'response': result1['remaining']!, 'tag': result1['json']!};
      } else {
        print(res.body);
      }
      return {'response': 'An internal error occurred', 'tag': ''};
    } catch (e) {
      return {'response': e.toString(), 'tag': ''};
    }
  }

  Map<String, String> extractJson(String response) {
    int start = response.indexOf('{');
    int end = response.lastIndexOf('}');

    String json =
        (start != -1 && end != -1) ? response.substring(start, end + 1) : '';
    String remaining = (start != -1 && end != -1)
        ? response.replaceRange(start, end + 1, '')
        : response;

    return {'json': json, 'remaining': remaining};
  }
}
