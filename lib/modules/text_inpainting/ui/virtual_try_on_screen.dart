import 'package:build_for_bharat/modules/text_inpainting/services/text_inpainting_service.dart';
import 'package:build_for_bharat/utils/gap.dart';
import 'package:build_for_bharat/utils/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class VirtualTryOnScreen extends StatefulWidget {
  const VirtualTryOnScreen({super.key});

  @override
  State<VirtualTryOnScreen> createState() => _VirtualTryOnScreenState();
}

class _VirtualTryOnScreenState extends State<VirtualTryOnScreen> {
  Uint8List? referenceImage;
  Uint8List? maskImage;
  Future<Uint8List>? resultImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        referenceImage != null
            ? Image.memory(
                referenceImage!,
                width: ScreenUtil.sw * 0.2,
                height: ScreenUtil.sh * 0.2,
              )
            : Container(),
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
        maskImage != null
            ? Image.memory(maskImage!,
                width: ScreenUtil.sw * 0.2, height: ScreenUtil.sh * 0.2)
            : Container(),
        SizedBox(
          height: Gap.xxshg,
        ),
        ElevatedButton(
            onPressed: () async {
              maskImage = await ImagePickerWeb.getImageAsBytes();

              setState(() {});
            },
            child: Text("Select Mask Image")),
        SizedBox(
          height: Gap.xxshg,
        ),
        ElevatedButton(
            onPressed: () {
              resultImage =
                  TextInpaintingService.postImage(referenceImage, maskImage);
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
              return CircularProgressIndicator();
            }
            return Container();
          },
        )
      ],
    );
  }
}
