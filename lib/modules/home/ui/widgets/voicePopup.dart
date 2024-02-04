import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:fluttertoast/fluttertoast.dart';

class VoicePopup extends StatefulWidget {
  @override
  _VoicePopupState createState() => _VoicePopupState();
}

class _VoicePopupState extends State<VoicePopup> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String text = '';
  @override
  void initState() {
    // TODO: implement initState
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Popup'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (!_isListening) {
              print('listening started');
              startListening();
            } else {
              print('stopped');
              stopListening();
            }
          },
          child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          stopListening();
          // _closePopup(text);
        },
        child: Icon(Icons.close),
      ),
    );
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
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          print(result.recognizedWords);
          setState(() {
            text = result.recognizedWords;
          });
          Fluttertoast.showToast(
            msg: 'Listening to: ${result.recognizedWords}',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blue,
          );
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
      Fluttertoast.showToast(
        msg: 'Speech recognition not available',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  void stopListening() {
    // _speech.stop();
    // _isListening = false;

    if (_isListening) {
      _speech.stop();

      _isListening = false;

      print('last print is' + _speech.lastRecognizedWords);
      _closePopup(text);
    }
    // Handle the case where stopListening is called without starting first
    else {
      print("Not currently listening");
    }
  }

  void _closePopup(String recognizedText) {
    print(text);
    Navigator.pop(context, recognizedText);
  }
}
