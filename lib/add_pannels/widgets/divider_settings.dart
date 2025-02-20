import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DividerSettings {
  final double indent;
  final double endIndent;
  final double thickness;
  final BoxDecoration? decoration;
  final Duration? duration;
  final Curve? curve;
  final bool isHideAutomatically;

  const DividerSettings({
    this.indent = 0,
    this.endIndent = 0,
    this.thickness = 1,
    this.decoration,
    this.duration,
    this.curve,
    this.isHideAutomatically = true,
  });

  @override
  bool operator ==(Object other) {
    return other is DividerSettings &&
        identical(indent, other.indent) &&
        identical(endIndent, other.endIndent) &&
        identical(thickness, other.thickness) &&
        identical(decoration, other.decoration) &&
        identical(duration, other.duration) &&
        identical(curve, other.curve) &&
        identical(isHideAutomatically, other.isHideAutomatically);
  }

  @override
  int get hashCode => Object.hashAll([
    indent,
    endIndent,
    thickness,
    decoration,
    duration,
    curve,
    isHideAutomatically,
  ]);
}

class CustomSegmentedController<T> extends ValueNotifier<T?> {
  CustomSegmentedController({T? value}) : super(value);
}

class CustomSegmentSettings {
  final Color splashColor;
  final Color highlightColor;
  final InteractiveInkFeatureFactory splashFactory;
  final BorderRadius? borderRadius;
  final double? radius;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? hoverColor;
  final MouseCursor? mouseCursor;

  CustomSegmentSettings({
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    this.splashFactory = NoSplash.splashFactory,
    this.borderRadius,
    this.radius,
    this.overlayColor,
    this.hoverColor,
    this.mouseCursor,
  });
}

class Cache<T> {
  final MapEntry<T?, Widget> item;
  final Size size;

  Cache({
    required this.item,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    if (other is Cache) {
      return identical(size, other.size) && identical(item, other.item);
    }
    return false;
  }

  @override
  int get hashCode => size.hashCode ^ item.hashCode;
}

double computeOffset<T>({
  required List<double> sizes,
  required List<T?> items,
  T? current,
}) {
  if (sizes.isNotEmpty && sizes.length == items.length) {
    return sizes
        .getRange(0, items.indexOf(current))
        .fold<double>(0, (previousValue, element) => previousValue + element);
  } else {
    return 0;
  }
}

class AnimationPanel<T> extends StatelessWidget {
  const AnimationPanel({
    super.key,
    required this.offset,
    required this.width,
    required this.height,
    required this.hasTouch,
    required this.duration,
    required this.curve,
    this.decoration,
  });

  final double offset;
  final double? width;
  final double? height;
  final Duration duration;
  final Curve curve;
  final bool hasTouch;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final _offset = isRtl ? offset * -1 : offset;

    return AnimatedContainer(
      transform: Matrix4.translationValues(_offset, 0, 0),
      duration: hasTouch == false ? Duration.zero : duration,
      curve: curve,
      width: width,
      decoration: decoration,
      height: height,
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final Function(Size size) onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(Duration d) {
    final context = widgetKey.currentContext;
    if (context == null) return;

    final Size? newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize ?? Size.zero);
  }
}




