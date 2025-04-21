import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// DefaultAlphabetListHeader
class DefaultAlphabetListHeader extends StatelessWidget {
  /// Constructor of DefaultAlphabetListHeader
  const DefaultAlphabetListHeader({
    required this.symbol,
    super.key,
    this.backgroundColor,
    this.style,
  });

  /// symbol
  final String symbol;

  /// background color
  final Color? backgroundColor;

  /// text style
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: backgroundColor,
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFECEAEA)))),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Text(
            symbol,
            style: style ??
                const TextStyle(
                    color: Color(0xFFAFABAB),
                    letterSpacing: -0.18,
                    height: 1,
                    fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('symbol', symbol))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<TextStyle?>('style', style));
  }
}
