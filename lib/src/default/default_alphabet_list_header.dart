/*
 * @Author: 王鹏 peng.wang@bigmarker.com
 * @Date: 2025-04-21 14:46:32
 * @LastEditors: 王鹏 peng.wang@bigmarker.com
 * @LastEditTime: 2025-04-21 16:20:10
 * @FilePath: /example/Users/wangxiaoying/Desktop/bigmarker/alphabet_list_view/lib/src/default/default_alphabet_list_header.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
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
