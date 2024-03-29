import 'dart:convert';
import 'dart:io';

import 'package:build_for_bharat/common/models/tags.dart';
import 'package:build_for_bharat/modules/home/ui/widgets/voicePopup.dart';
import 'package:build_for_bharat/openai_service.dart';
import 'package:build_for_bharat/productProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

import 'package:uuid/uuid.dart';

void main() {
  // initializeDateFormatting()
  //     .then((_) => runApp(const ChatPage(isProduct: false)));
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.isProduct});
  final bool isProduct;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // ProductProvider productProvider =

  // Use productProvider to call the function and update the list.
  // Example: productProvider.updateList(tags);
  bool isStart = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  FlutterTts flutterTts = FlutterTts();
  String text = '';
  String langCode = "hi-IN";
  double _confidence = 1.0;
  // List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _bot = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3bd');
  // bool isProduct = false;
  bool isDataLoading = false;
  late final OpenAIService openAIService;

  @override
  void initState() {
    super.initState();

    openAIService =
        Provider.of<ProductProvider>(context, listen: false).openAiService;
    if (!widget.isProduct) {
      setState(() {
        isStart = true;
      });
      _handleSendPressed(types.PartialText(text: 'Hi'));
    }
    print('init called ${widget.isProduct} ${isStart}');

    Provider.of<ProductProvider>(context, listen: false).isListening = false;
    flutterTts.setSpeechRate(1.0);
    flutterTts.setLanguage(langCode);
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      Provider.of<ProductProvider>(context, listen: false)
          .messages
          .insert(0, message);
      Provider.of<ProductProvider>(context, listen: false).alterMessages();
    });
  }

  void _handleAttachmentPressed() {
    // showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) => SafeArea(
    //     child: SizedBox(
    //       height: 144,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               _handleImageSelection();
    //             },
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('Photo'),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               _handleFileSelection();
    //             },
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('Voice'),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: const Align(
    //               alignment: AlignmentDirectional.centerStart,
    //               child: Text('Cancel'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    _handleFileSelection();
  }

  void _handleFileSelection() async {
    if (!_isListening) {
      print('listening started');
      startListening();
    } else {
      print('stopped');
      stopListening();
      _handleSendPressed(types.PartialText(text: text));
    }
    // Do something with _recognizedText
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      print(
          'height : ${image.height.toDouble()}, name : ${result.name}, size : ${bytes.length}, uri : ${result.path}, width : ${image.width.toDouble()}');
      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index = Provider.of<ProductProvider>(context, listen: false)
              .messages
              .indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (Provider.of<ProductProvider>(context, listen: false)
                      .messages[index] as types.FileMessage)
                  .copyWith(
            isLoading: true,
          );

          setState(() {
            Provider.of<ProductProvider>(context, listen: false)
                .messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index = Provider.of<ProductProvider>(context, listen: false)
              .messages
              .indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (Provider.of<ProductProvider>(context, listen: false)
                      .messages[index] as types.FileMessage)
                  .copyWith(
            isLoading: null,
          );

          setState(() {
            Provider.of<ProductProvider>(context, listen: false)
                .messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = Provider.of<ProductProvider>(context, listen: false)
        .messages
        .indexWhere((element) => element.id == message.id);
    final updatedMessage = (Provider.of<ProductProvider>(context, listen: false)
            .messages[index] as types.TextMessage)
        .copyWith(
      previewData: previewData,
    );

    setState(() {
      Provider.of<ProductProvider>(context, listen: false).messages[index] =
          updatedMessage;
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      isDataLoading = true;
    });
    _addMessage(textMessage);
    bool addprod = containsSubsequence(message.text);

    Map<String, String> aiResponse =
        await openAIService.chatGPTAPI(message.text, isStart);
    // aiResponse['response'] =
    //     aiResponse['response']!.replaceAll("here is the current tag json", "");
    // aiResponse['response'] =
    //     aiResponse['response']!.replaceAll("Here is your current tag json", "");
    // aiResponse['response'] =
    //     aiResponse['response']!.replaceAll("Here is the current tag json", "");
    // aiResponse['response'] =
    //     aiResponse['response']!.replaceAll("here is your current tag json", "");

    final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        id: const Uuid().v4(),
        text: aiResponse['response']!);

    bool care = aiResponse['tag']?.trim() == '' ? false : true;
    print(aiResponse['tag']);
    Tags tags = parseTags(aiResponse['tag']!);

    Provider.of<ProductProvider>(context, listen: false).updateList(tags, care);
    if (care &&
        Provider.of<ProductProvider>(context, listen: false).prod_list.length >
            0) {
      String url =
          'https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d';
      // _handleImageSelection()
      // final result = await ImagePicker().pickImage(
      //   imageQuality: 70,
      //   maxWidth: 1440,
      //   source: ImageSource.gallery,
      // );

      final message = types.ImageMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        name: 'best pick',
        size: 188021,
        uri:
            'https://img.freepik.com/free-vector/t-shirt-poster-design-with-illustraion-skeleton-professor_1284-36769.jpg',
      );

      setState(() {
        Provider.of<ProductProvider>(context, listen: false)
            .messages
            .insert(0, message);

        Provider.of<ProductProvider>(context, listen: false).notifyListeners();
      });
      // _handleImageSelection();
    }
    setState(() {
      isDataLoading = false;
      isStart = false;
    });
    _addMessage(botMessage);
    if (addprod) {
      Provider.of<ProductProvider>(context, listen: false).addtoCart = true;
      print(Provider.of<ProductProvider>(context, listen: false).addtoCart);
      Provider.of<ProductProvider>(context, listen: false).notifyListeners();
    }
    _speak(aiResponse['response']!);
  }

  bool containsSubsequence(String text) {
    final words = text.toLowerCase().split(' ');

    bool addFound = false;
    bool toFound = false;
    bool cartFound = false;

    for (final word in words) {
      if (word == 'add') {
        addFound = true;
      } else if (word == 'to' && addFound) {
        toFound = true;
      } else if (word == 'cart' && toFound) {
        cartFound = true;
      }

      if (addFound && toFound && cartFound) {
        return true; // Subsequence found
      }
    }

    return false; // Subsequence not found
  }

  Tags parseTags(String jsonString) {
    if (jsonString.trim() == '')
      return Tags(
          cart: [],
          category: '',
          max_price: '',
          color: '',
          sizes: '',
          weather_suitable: '',
          occasion: '',
          brand: '');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Tags.fromJson(jsonMap);
  }

  void _loadMessages() async {
    // final response = await rootBundle.loadString('assets/messages.json');
    final messages =
        Provider.of<ProductProvider>(context, listen: false).messages;
    setState(() {
      Provider.of<ProductProvider>(context, listen: false).messages = messages;
    });
  }

  void startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Speech recognition status: $status");
      },
      onError: (errorNotification) {
        print("Speech recognition error: $errorNotification");
      },
    );

    if (available) {
      setState(() {
        Provider.of<ProductProvider>(context, listen: false).isListening = true;
        // Provider.of<ProductProvider>(context,listen:false).tags.cart
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          // print(result.recognizedWords);
          setState(() {
            text = result.recognizedWords;
          });
        },
        // onError: (error) {
        //   print(error);
        //   Fluttertoast.showToast(
        //     msg: 'Error: $error',
        //     gravity: ToastGravity.BOTTOM,
        //     backgroundColor: Colors.red,
        //   );
        // },
      );
    } else {
      print("Speech recognition not available");
    }
  }

  void stopListening() {
    // _speech.stop();
    // _isListening = false;

    if (_isListening) {
      _speech.stop();
      setState(() {
        Provider.of<ProductProvider>(context, listen: false).isListening =
            false;
        _isListening = false;
      });

      // print('last print is' + _speech.lastRecognizedWords);
    }
    // Handle the case where stopListening is called without starting first
    else {
      print("Not currently listening");
    }
  }

  void _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      return Scaffold(
        body: Chat(
          messages:
              Provider.of<ProductProvider>(context, listen: false).messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );
    });
  }
}
