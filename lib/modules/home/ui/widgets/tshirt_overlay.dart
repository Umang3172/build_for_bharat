import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TShirtTryOnPage extends StatefulWidget {
  @override
  _TShirtTryOnPageState createState() => _TShirtTryOnPageState();
}

class _TShirtTryOnPageState extends State<TShirtTryOnPage> {
  double _overlayScale = 1.0; // Initial scale factor for the overlay image
  double _minScale = 0.5; // Minimum scale factor for the overlay image
  double _maxScale = 2.0; // Maximum scale factor for the overlay image
  static const double _scaleFactor = 0.1; // Scale factor for zooming

  String? _selectedImageUrl;
  bool _showOverlay = true; // Initially show the overlay
  Offset _overlayPosition =
      Offset(0, 0); // Initial position for the overlay image

  void _updateOverlayScale(double scaleFactor) {
    setState(() {
      // Update the scale factor based on the pinch gesture
      _overlayScale *= (1.0 + scaleFactor * _scaleFactor);
      // Ensure the scale factor stays within the specified range
      _overlayScale = _overlayScale.clamp(_minScale, _maxScale);
    });
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImageUrl = pickedImage.path;
        _showOverlay = true; // Show the overlay when a new image is picked
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _overlayScale += _scaleFactor;
      _overlayScale = _overlayScale.clamp(_minScale, _maxScale);
    });
  }

  void _zoomOut() {
    setState(() {
      _overlayScale -= _scaleFactor;
      _overlayScale = _overlayScale.clamp(_minScale, _maxScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual T-shirt Try-On'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onScaleUpdate: (details) {
              // Calculate the scale factor based on the scale update details
              _updateOverlayScale(details.scale - 1.0);
            },
            child: _selectedImageUrl == null
                ? Center(
                    child: Text(
                      'Select an Image from Gallery',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Center(
                    child: Image.network(
                      _selectedImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // Update the position of the overlay based on the drag update
                _overlayPosition += details.delta;
              });
            },
            child: _showOverlay
                ? Center(
                    child: Transform.scale(
                      scale: _overlayScale,
                      child: Transform.translate(
                        offset: _overlayPosition,
                        child: Image.asset(
                          'blue_bg.png', // Adjust the image path accordingly
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  )
                : SizedBox(), // Hide the overlay if _showOverlay is false
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickImageFromGallery,
            child: Icon(Icons.photo_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _zoomIn,
            child: Icon(Icons.zoom_in),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _zoomOut,
            child: Icon(Icons.zoom_out),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _showOverlay = !_showOverlay; // Toggle the overlay visibility
              });
            },
            child: Icon(_showOverlay ? Icons.visibility : Icons.visibility_off),
          ),
        ],
      ),
    );
  }
}
