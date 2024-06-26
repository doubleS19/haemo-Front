import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haemo/common/theme.dart';

class CheckMarkIndicator extends StatefulWidget {
  final Widget child;
  final Set<void> onClick;

  const CheckMarkIndicator(
      {Key? key, required this.child, required this.onClick})
      : super(key: key);

  @override
  _CheckMarkIndicatorState createState() => _CheckMarkIndicatorState();
}

class _CheckMarkIndicatorState extends State<CheckMarkIndicator>
    with SingleTickerProviderStateMixin {
  static const _indicatorSize = 150.0;

  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: () async =>
          {widget.onClick, Future.delayed(const Duration(seconds: 2))},
      child: widget.child,
      onStateChanged: (change) {
        if (change.didChange(to: IndicatorState.complete)) {
          setState(() {
            _renderCompleteState = true;
          });
        } else if (change.didChange(to: IndicatorState.idle)) {
          setState(() {
            _renderCompleteState = false;
          });
        }
      },
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? _) {
                  if (controller.scrollingDirection ==
                          ScrollDirection.reverse &&
                      prevScrollDirection == ScrollDirection.forward) {
                    if (controller.state == IndicatorState.armed) {
                      controller.stopDrag();
                    }
                  }
                  prevScrollDirection = controller.scrollingDirection;

                  final containerHeight = controller.value * _indicatorSize;

                  return controller.isDragging
                      ? Container(
                          alignment: Alignment.center,
                          height: containerHeight,
                          child: OverflowBox(
                            maxHeight: 40,
                            minHeight: 40,
                            maxWidth: 40,
                            minWidth: 40,
                            alignment: Alignment.center,
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              height: 30,
                              width: 30,
                              child: customIndicator(30, 3000),
                            ),
                          ),
                        )
                      : Container();
                }),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _indicatorSize),
                  child: child,
                );
              },
              animation: controller,
            )
          ],
        );
      },
    );
  }
}

Widget customIndicator(double size, int duration) {
  return SpinKitFadingCircle(
      color: CustomThemes.mainTheme.primaryColor,
      size: size,
      duration: Duration(milliseconds: duration));
}
