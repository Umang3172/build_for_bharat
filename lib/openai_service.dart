import 'dart:convert';

import 'package:build_for_bharat/utils/strings.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  static const apiUri = 'https://api.openai.com/v1/chat/completions';
  static const apiKey = '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';

  Future<String> chatGPTAPI(String prompt, bool isStart) async {
    return "Yes";
    // if (isStart) {
    //   prompt = Strings.rules;
    // }
    // messages.add({
    //   "role": "user",
    //   "content": prompt,
    // });
    // try {
    //   final res = await http.post(
    //     Uri.parse(apiUri),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       "Authorization": 'Bearer $apiKey',
    //       'OpenAI-Organization': ''
    //     },
    //     body: jsonEncode({
    //       "model": "gpt-3.5-turbo",
    //       "messages": messages,
    //       "temperature": 0.7
    //     }),
    //   );

    //   //print(res.body);

    //   if (res.statusCode == 200) {
    //     String content =
    //         jsonDecode(res.body)['choices'][0]['message']['content'];
    //     content = content.trim();

    //     messages.add({
    //       'role': 'assistant',
    //       'content': content,
    //     });
    //     return content;
    //   } else {
    //     print(res.body);
    //   }
    //   return 'An internal error occurred';
    // } catch (e) {
    //   return e.toString();
    // }
  }
}
