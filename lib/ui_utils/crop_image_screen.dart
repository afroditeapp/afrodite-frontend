
import "dart:math";

import "package:camera/camera.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:openapi/api.dart";

import 'package:pihka_frontend/localizations.dart';
import "package:pihka_frontend/ui_utils/consts/corners.dart";
import "package:pihka_frontend/ui_utils/image.dart";


class CropImageFileContent {
  CropImageFileContent(this.imageOwner, this.imageId, this.imageFile, this.imgWidth, this.imgHeight, this.cropResults);
  final AccountId imageOwner;
  final ContentId imageId;
  final XFile imageFile;
  final int imgWidth;
  final int imgHeight;
  final CropResults cropResults;
}

const MIN_CROP_ALLOWED_FACTOR = 0.75;


/// When navigating away from this screen, the result will be a [CropResults] object.
class CropImageScreen extends StatefulWidget {
  const CropImageScreen(this.info, {super.key});
  final CropImageFileContent info;

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  CropState? cropState;
  double areaWidth = 1;
  double areaHeight = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, calculateCropResults());
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.crop_image_screen_title)),
        body: buildCropArea(),
      ),
    );
  }

  Widget buildCropArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final (imgFile, imgWidth, imgHeight) = switch (widget.info) {
          CropImageFileContent(:final imageFile, :final imgWidth, :final imgHeight) =>
            (
              imageFile,
              imgWidth,
              imgHeight
            ),
        };

        final double imgWidgetWidth;
        final double imgWidgetHeight;
        if (constraints.maxWidth < constraints.maxHeight) {
          // portrait
          final imgAspect = imgWidth / imgHeight;
          final areaAspect = constraints.maxWidth / constraints.maxHeight;
          final heightFactor = areaAspect / imgAspect;

          imgWidgetWidth = constraints.maxWidth;
          imgWidgetHeight = constraints.maxHeight * heightFactor;
        } else {
          // landscape
          final imgAspect = imgHeight / imgWidth;
          final areaAspect = constraints.maxHeight / constraints.maxWidth;
          final widthFactor = areaAspect / imgAspect;

          imgWidgetWidth = constraints.maxWidth * widthFactor;
          imgWidgetHeight = constraints.maxHeight;
        }

        final imgWidget = xfileImgWidget(
          imgFile,
          width: imgWidgetWidth,
          height: imgWidgetHeight,
          alignment: Alignment.topLeft
        );

        log.info("Constraints: $constraints");
        log.info("Image width: $imgWidth");
        log.info("Image height: $imgHeight");
        log.info("Image widget width: $imgWidgetWidth");
        log.info("Image widget height: $imgWidgetHeight");

        final selectionMaxSize = min(imgWidgetWidth, imgWidgetHeight);

        areaWidth = imgWidgetWidth;
        areaHeight = imgWidgetHeight;

        final currentCropState = cropState;
        final CropState c;
        if (currentCropState == null) {
          c = CropState(
            areaWidth * widget.info.cropResults.gridCropX,
            areaHeight * widget.info.cropResults.gridCropY,
            selectionMaxSize * widget.info.cropResults.gridCropSize,
          );
          cropState = c;
        } else {
          c = currentCropState;
        }

        return Center(
          child: CropImageOverlay(
            cropState: c,
            selectionMaxSize: selectionMaxSize,
            areaWidth: imgWidgetWidth,
            areaHeight: imgWidgetHeight,
            imageWidget: Align(
              alignment: Alignment.topLeft,
              child: imgWidget,
            ),
          ),
        );
      }
    );
  }

  CropResults? calculateCropResults() {
    final s = cropState;
    if (s == null) {
      return null;
    }

    final gridCropSize = s.size / min(areaWidth, areaHeight);
    final gridCropX = s.left / areaWidth;
    final gridCropY = s.top / areaHeight;

    log.info("Crop results: size: $gridCropSize, x: $gridCropX, y: $gridCropY");

    return CropResults.fromValues(gridCropSize, gridCropX, gridCropY);
  }
}

class CropState {
  CropState(this.left, this.top, this.size);
  double left;
  double top;
  double size;
}

class CropResults {
  /// Values are between [MIN_CROP_ALLOWED_FACTOR] and 1.
  /// The shorter side of the image should be multiplied by this
  /// factor to get the crop side length.
  final double gridCropSize;
  /// Top left corner location difference relative to the image width.
  final double gridCropX;
  /// Top left corner location difference relative to the image height.
  final double gridCropY;

  const CropResults._(this.gridCropSize, this.gridCropX, this.gridCropY);

  static CropResults fromValues(double gridCropSize, double gridCropX, double gridCropY) {
    return CropResults._(
      clampDouble(gridCropSize, MIN_CROP_ALLOWED_FACTOR, 1.0),
      gridCropX,
      gridCropY
    );
  }

  /// Square image from top left corner.
  static const full =
    CropResults._(
      1.0,
      0.0,
      0.0,
    );
}

class CropImageOverlay extends StatefulWidget {
  const CropImageOverlay({
    required this.imageWidget,
    required this.selectionMaxSize,
    required this.areaWidth,
    required this.areaHeight,
    required this.cropState,
    Key? key,
  }) : super(key: key);
  final Widget imageWidget;
  final double selectionMaxSize;
  final double areaWidth;
  final double areaHeight;
  final CropState cropState;

  @override
  _CropImageOverlayState createState() => _CropImageOverlayState();
}

class _CropImageOverlayState extends State<CropImageOverlay> {
  double get _left => widget.cropState.left;
  set _left(double left) => widget.cropState.left = left;

  double get _top => widget.cropState.top;
  set _top(double top) => widget.cropState.top = top;

  double get _size => widget.cropState.size;
  set _size(double size) => widget.cropState.size = size;

  @override
  void initState() {
    super.initState();
    checkSizeBounds();
    checkLocationBounds();
  }

  @override
  Widget build(BuildContext context) {
    // Refresh selection when screen rotates
    checkSizeBounds();
    checkLocationBounds();

    return Stack(
      children: [
        widget.imageWidget,
        Positioned(
          left: _left,
          top: _top,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                moveSelectionBox(details.delta.dx, details.delta.dy);
              });
            },
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PROFILE_PICTURE_BORDER_RADIUS),
                color: Colors.grey.withOpacity(0.7),
              ),
              child: scalingHandles(),
            ),
          ),
        ),
      ],
    );
  }

  Widget scalingHandles() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: handle(Alignment.topLeft)
              ),
              Expanded(
                child: handle(Alignment.bottomLeft)
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: handle(Alignment.topRight)
              ),
              Expanded(
                child: handle(Alignment.bottomRight)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget handle(Alignment alignment) {
    const r = Radius.circular(PROFILE_PICTURE_BORDER_RADIUS);
    final BorderRadius radius;
    final void Function(double, double) scaleAction;
    if (alignment == Alignment.topLeft) {
      radius = const BorderRadius.only(
        topLeft: r,
      );
      scaleAction = scaleUsingTopLeftHandle;
    } else if (alignment == Alignment.topRight) {
      radius = const BorderRadius.only(
        topRight: r,
      );
      scaleAction = scaleUsingTopRightHandle;
    } else if (alignment == Alignment.bottomLeft) {
      radius = const BorderRadius.only(
        bottomLeft: r,
      );
      scaleAction = scaleUsingBottomLeftHandle;
    } else {
      radius = const BorderRadius.only(
        bottomRight: r,
      );
      scaleAction = scaleUsingBottomRightHandle;
    }

    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            scaleAction(details.delta.dx, details.delta.dy);
          });
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: radius,
          ),
        ),
      ),
    );
  }

  void moveSelectionBox(double dx, double dy) {
    _left += dx;
    _top += dy;
    checkLocationBounds();
  }

  void scaleUsingTopLeftHandle(double dx, double dy) {
    final newSize = _size - dx;
    if (newSize >= selectionMinSize()) {
      _size = newSize;
      _left += dx;
      _top += dx;
    } else if (_size != selectionMinSize()) {
      // The if condition prevents running this multiple times
      _size = selectionMinSize();
      // Calculate dx which matches selectionMinSize()
      _left += dx + (newSize - selectionMinSize());
      _top += dx + (newSize - selectionMinSize());
    }

    checkSizeBounds();
    checkLocationBounds();
  }

  void scaleUsingTopRightHandle(double dx, double dy) {
    final newSize = _size + dx;
    if (newSize >= selectionMinSize()) {
      _size = newSize;
      _top -= dx;
    } else if (_size != selectionMinSize()) {
      // The if condition prevents running this multiple times
      _size = selectionMinSize();
      // Calculate dx which matches selectionMinSize()
      _top -= dx - (newSize - selectionMinSize());
    }

    checkSizeBounds();
    checkLocationBounds();
  }

  void scaleUsingBottomLeftHandle(double dx, double dy) {
    final newSize = _size - dx;
    if (newSize >= selectionMinSize()) {
      _size = newSize;
      _left += dx;
    } else if (_size != selectionMinSize()) {
      // The if condition prevents running this multiple times
      _size = selectionMinSize();
      // Calculate dx which matches selectionMinSize()
      _left += dx + (newSize - selectionMinSize());
    }

    checkSizeBounds();
    checkLocationBounds();
  }

  void scaleUsingBottomRightHandle(double dx, double dy) {
    _size += dx;
    checkSizeBounds();
    checkLocationBounds();
  }

  void checkSizeBounds() {
    _size = min(max(selectionMinSize(), _size), widget.selectionMaxSize);
  }

  void checkLocationBounds() {
    _left = min(max(0, _left), widget.areaWidth - _size);
    _top = min(max(0, _top), widget.areaHeight - _size);
  }

  double selectionMinSize() {
    return widget.selectionMaxSize * MIN_CROP_ALLOWED_FACTOR;
  }
}
