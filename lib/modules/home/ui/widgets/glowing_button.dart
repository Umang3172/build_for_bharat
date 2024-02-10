import 'package:build_for_bharat/modules/home/ui/widgets/tshirt_overlay.dart';
import 'package:build_for_bharat/modules/text_inpainting/ui/virtual_try_on_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;

  const GlowingButton(
      {super.key, this.color1 = Colors.cyan, this.color2 = Colors.greenAccent});
  @override
  State<StatefulWidget> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  List<CameraDescription> camerasList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initializeCamera();
  }

  // TODO: implement build
  var glowing = false;
  var scale = 1.0;
  @override
  Widget build(BuildContext context) {
    //On mobile devices, gesture detector is perfect
    //However for desktop and web we can show this effect on hover too
    // _initializeCamera();
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TShirtTryOnPage())),
      },
      onTapUp: (val) {
        setState(() {
          glowing = false;
          scale = 1.0;
        });
      },
      onTapDown: (val) {
        setState(() {
          glowing = true;
          scale = 1.1;
        });
      },
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        duration: Duration(milliseconds: 200),
        height: 48,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
            boxShadow: glowing
                ? [
                    BoxShadow(
                      color: widget.color1.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(8, 0),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: Offset(8, 0),
                    )
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              glowing ? Icons.lightbulb : Icons.lightbulb_outline,
              color: Colors.white,
            ),
            Text(
              "Try On",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
//  
