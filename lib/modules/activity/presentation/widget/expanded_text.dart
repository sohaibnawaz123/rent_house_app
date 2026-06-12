import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextStyle? actionStyle;
  final String readMoreText;
  final String readLessText;

  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
    this.actionStyle,
    this.readMoreText = ' Read more',
    this.readLessText = ' Read less',
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool expanded = false;

  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();

    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          expanded = !expanded;
        });
      };
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ?? const TextStyle(fontSize: 14);

    final actionStyle =
        widget.actionStyle ??
        defaultStyle.copyWith(color: Colors.blue, fontWeight: FontWeight.bold);

    return LayoutBuilder(
      builder: (context, constraints) {
        final text = expanded
            ? widget.text
            : _truncateText(
                maxWidth: constraints.maxWidth,
                style: defaultStyle,
                actionStyle: actionStyle,
                textScaler: MediaQuery.textScalerOf(context),
              );

        return RichText(
          text: TextSpan(
            text: text,
            style: defaultStyle,
            children: [
              TextSpan(
                text: expanded ? widget.readLessText : widget.readMoreText,
                style: actionStyle,
                recognizer: _recognizer,
              ),
            ],
          ),
        );
      },
    );
  }

  String _truncateText({
    required double maxWidth,
    required TextStyle style,
    required TextStyle actionStyle,
    required TextScaler textScaler,
  }) {
    const dots = '.....';

    var low = 0;
    var high = widget.text.length;

    var result = widget.text;

    while (low <= high) {
      final mid = (low + high) ~/ 2;

      final candidate = '${widget.text.substring(0, mid).trimRight()}$dots';

      final painter = TextPainter(
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
        text: TextSpan(
          text: candidate,
          style: style,
          children: [TextSpan(text: widget.readMoreText, style: actionStyle)],
        ),
      )..layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines) {
        high = mid - 1;
      } else {
        result = candidate;
        low = mid + 1;
      }
    }

    return result;
  }
}
