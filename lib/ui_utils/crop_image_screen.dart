import "dart:math";

import "package:app/data/image_cache.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";

import 'package:app/localizations.dart';
import "package:app/ui_utils/consts/corners.dart";
import "package:app/ui_utils/image.dart";

final _log = Logger("CropImageScreen");

class CropImageFileContent {
  CropImageFileContent(this.imageOwner, this.imageId, this.imgWidth, this.imgHeight, this.cropArea);
  final AccountId imageOwner;
  final ContentId imageId;
  final int imgWidth;
  final int imgHeight;
  final CropArea cropArea;
}

const MIN_CROP_ALLOWED_FACTOR = 0.75;

class CropImagePage extends MyScreenPageLimited<()> {
  CropImagePage({
    required CropImageFileContent info,
    required void Function(CropArea?) onCropAreaChanged,
  }) : super(
         builder: (_) => CropImageScreen(info: info, onCropAreaChanged: onCropAreaChanged),
       );
}

class CropImageScreen extends StatefulWidget {
  final CropImageFileContent info;
  final void Function(CropArea?) onCropAreaChanged;
  const CropImageScreen({required this.info, required this.onCropAreaChanged, super.key});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  CropState? cropState;
  double areaWidth = 1;
  double areaHeight = 1;

  CropArea? cropAreaCache;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.crop_image_screen_title)),
      body: buildCropArea(),
    );
  }

  Widget buildCropArea() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final (imageOwner, imageId, imgWidth, imgHeight) = switch (widget.info) {
          CropImageFileContent(
            :final imageOwner,
            :final imageId,
            :final imgWidth,
            :final imgHeight,
          ) =>
            (imageOwner, imageId, imgWidth, imgHeight),
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

        final imgWidget = accountImgWidget(
          context,
          imageOwner,
          imageId,
          width: imgWidgetWidth,
          height: imgWidgetHeight,
          alignment: Alignment.topLeft,
          cacheSize: ImageCacheSize.maxDisplaySize(),
        );

        _log.fine("Constraints: $constraints");
        _log.fine("Image width: $imgWidth");
        _log.fine("Image height: $imgHeight");
        _log.fine("Image widget width: $imgWidgetWidth");
        _log.fine("Image widget height: $imgWidgetHeight");

        final selectionMaxSize = min(imgWidgetWidth, imgWidgetHeight);

        areaWidth = imgWidgetWidth;
        areaHeight = imgWidgetHeight;

        final currentCropState = cropState;
        final CropState c;
        if (currentCropState == null) {
          c = CropState(
            areaWidth * widget.info.cropArea.gridCropX,
            areaHeight * widget.info.cropArea.gridCropY,
            selectionMaxSize * widget.info.cropArea.gridCropSize,
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
            imageWidget: Align(alignment: Alignment.topLeft, child: imgWidget),
            onBuildCalled: (cropState) {
              final cropArea = _calculateCropArea(cropState, areaWidth, areaHeight);
              if (cropArea != cropAreaCache) {
                cropAreaCache = cropArea;
                widget.onCropAreaChanged(cropArea);
              }
            },
          ),
        );
      },
    );
  }
}

CropArea _calculateCropArea(CropState s, double areaWidth, double areaHeight) {
  final gridCropSize = s.size / min(areaWidth, areaHeight);
  final gridCropX = s.left / areaWidth;
  final gridCropY = s.top / areaHeight;

  // log.fine("Crop area: size: $gridCropSize, x: $gridCropX, y: $gridCropY");

  return CropArea.fromValues(gridCropSize, gridCropX, gridCropY);
}

class CropState {
  CropState(this.left, this.top, this.size);
  double left;
  double top;
  double size;
}

class CropArea {
  /// Values are between [MIN_CROP_ALLOWED_FACTOR] and 1.
  /// The shorter side of the image should be multiplied by this
  /// factor to get the crop side length.
  final double gridCropSize;

  /// Top left corner location difference relative to the image width.
  final double gridCropX;

  /// Top left corner location difference relative to the image height.
  final double gridCropY;

  const CropArea._(this.gridCropSize, this.gridCropX, this.gridCropY);

  static CropArea fromValues(double gridCropSize, double gridCropX, double gridCropY) {
    return CropArea._(
      clampDouble(gridCropSize, MIN_CROP_ALLOWED_FACTOR, 1.0),
      gridCropX,
      gridCropY,
    );
  }

  /// Square image from top left corner.
  static const full = CropArea._(1.0, 0.0, 0.0);

  @override
  bool operator ==(Object other) {
    if (other is CropArea) {
      return gridCropSize == other.gridCropSize &&
          gridCropX == other.gridCropX &&
          gridCropY == other.gridCropY;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(gridCropSize, gridCropX, gridCropY);
}

class CropImageOverlay extends StatefulWidget {
  const CropImageOverlay({
    required this.imageWidget,
    required this.selectionMaxSize,
    required this.areaWidth,
    required this.areaHeight,
    required this.cropState,
    required this.onBuildCalled,
    super.key,
  });
  final Widget imageWidget;
  final double selectionMaxSize;
  final double areaWidth;
  final double areaHeight;
  final CropState cropState;
  final void Function(CropState) onBuildCalled;

  @override
  State<CropImageOverlay> createState() => _CropImageOverlayState();
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

    widget.onBuildCalled(widget.cropState);

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
                color: Colors.grey.withValues(alpha: 0.7),
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
              Expanded(child: handle(Alignment.topLeft)),
              Expanded(child: handle(Alignment.bottomLeft)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(child: handle(Alignment.topRight)),
              Expanded(child: handle(Alignment.bottomRight)),
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
      radius = const BorderRadius.only(topLeft: r);
      scaleAction = scaleUsingTopLeftHandle;
    } else if (alignment == Alignment.topRight) {
      radius = const BorderRadius.only(topRight: r);
      scaleAction = scaleUsingTopRightHandle;
    } else if (alignment == Alignment.bottomLeft) {
      radius = const BorderRadius.only(bottomLeft: r);
      scaleAction = scaleUsingBottomLeftHandle;
    } else {
      radius = const BorderRadius.only(bottomRight: r);
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
          decoration: BoxDecoration(color: Colors.black45, borderRadius: radius),
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
