import 'dart:async';

import 'package:build_for_bharat/modules/text_inpainting/services/text_inpainting_service.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:build_for_bharat/utils/styles.dart';
import 'package:build_for_bharat/utils/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:video_player/video_player.dart';

class VirtualTryOnScreen extends StatefulWidget {
  const VirtualTryOnScreen({super.key});

  @override
  State<VirtualTryOnScreen> createState() => _VirtualTryOnScreenState();
}

class _VirtualTryOnScreenState extends State<VirtualTryOnScreen> {
  Uint8List? referenceImage;
  Uint8List? maskImage;
  Future<Uint8List>? resultImage;

  final _controller = VideoPlayerController.asset(
    "assets/text_inpainting.mp4",
  );
  final promptTextEditingController = TextEditingController();
  bool _visible = false;

  void initializeVideo() {
    _controller.initialize().then((_) {
      _controller.setLooping(true);

      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
  }

  void initImage() async {
    final ByteData bytes = await rootBundle.load('mask.png');
    maskImage = bytes.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    initializeVideo();
    initImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'AI Fashion',
                style:
                    Styles.largeHeaderText.apply(color: AppColors.primaryColor),
              ),
              SizedBox(
                height: Gap.xxxshg,
              ),
              Text(
                'Take your Imagination to next level by using our next gen AI tools',
                style:
                    Styles.tsw400xs.apply(color: AppColors.secondaryTextColor),
              ),
              SizedBox(
                height: Gap.xxxshg,
              ),
              SizedBox(
                height: ScreenUtil.sh * 0.5,
                width: ScreenUtil.sw,
                child: VideoPlayer(
                  _controller,
                ),
              ),
              SizedBox(
                height: Gap.xxshg,
              ),
              SizedBox(
                width: ScreenUtil.sw * 0.4,
                height: ScreenUtil.sh * 0.1,
                child: TextField(
                  controller: promptTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Prompt',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: Gap.xxxshg),
              Container(
                width: ScreenUtil.sw * 0.2,
                height: ScreenUtil.sh * 0.3,
                child: referenceImage != null
                    ? Image.memory(
                        referenceImage!,
                        width: ScreenUtil.sw * 0.2,
                        height: ScreenUtil.sh * 0.2,
                      )
                    : Image.asset('pick_image.jpg'),
              ),
              SizedBox(
                height: Gap.xxshg,
              ),
              ElevatedButton(
                  onPressed: () async {
                    referenceImage = await ImagePickerWeb.getImageAsBytes();

                    setState(() {});
                  },
                  child: Text("Select Reference Image")),
              SizedBox(
                height: Gap.xxshg,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (referenceImage == null) {
                      resultImage = TextInpaintingService.textPromptToImage(
                          promptTextEditingController.text);
                    } else {
                      resultImage = TextInpaintingService.postImage(
                          referenceImage,
                          maskImage,
                          promptTextEditingController.text);
                    }

                    setState(() {});
                  },
                  child: Text("Continue")),
              SizedBox(
                height: Gap.xxshg,
              ),
              FutureBuilder(
                future: resultImage,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Image.memory(
                      snapshot.data!,
                      width: ScreenUtil.sw * 0.2,
                      height: ScreenUtil.sh * 0.2,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
