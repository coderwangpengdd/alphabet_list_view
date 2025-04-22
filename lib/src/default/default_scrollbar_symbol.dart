/*
 * @Author: 王鹏 peng.wang@bigmarker.com
 * @Date: 2025-04-21 14:46:32
 * @LastEditors: 王鹏 peng.wang@bigmarker.com
 * @LastEditTime: 2025-04-22 13:33:34
 * @FilePath: /example/Users/wangxiaoying/Desktop/bigmarker/alphabet_list_view/lib/src/default/default_scrollbar_symbol.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// DefaultScrollbarSymbol
class DefaultScrollbarSymbol extends StatelessWidget {
  /// Constructor of DefaultScrollbarSymbol
  const DefaultScrollbarSymbol(
      {required this.symbol,
      required this.state,
      super.key,
      this.styleActive,
      this.styleInactive,
      this.styleDeactivated,
      this.fontSize = 10,
      this.fontFamily});

  final String? fontFamily;

  final double? fontSize;

  /// symbol
  final String symbol;

  /// state of item
  final AlphabetScrollbarItemState state;

  /// style if symbol is active
  final TextStyle? styleActive;

  /// style if symbol is inactive
  final TextStyle? styleInactive;

  /// style if symbol is deactivated
  final TextStyle? styleDeactivated;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (state) {
      AlphabetScrollbarItemState.active => styleActive ??
          TextStyle(
              color: Color(0xFF883FFF),
              fontSize: fontSize,
              fontFamily: fontFamily),
      AlphabetScrollbarItemState.inactive => styleInactive ??
          TextStyle(
              color: Color(0xFF883FFF),
              fontSize: fontSize,
              fontFamily: fontFamily),
      AlphabetScrollbarItemState.deactivated => styleDeactivated ??
          TextStyle(
              color: Color(0xFFDBD7D7),
              fontSize: fontSize,
              fontFamily: fontFamily),
    };

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        symbol,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('symbol', symbol))
      ..add(EnumProperty<AlphabetScrollbarItemState>('state', state))
      ..add(DiagnosticsProperty<TextStyle?>('styleActive', styleActive))
      ..add(DiagnosticsProperty<TextStyle?>('styleInactive', styleInactive))
      ..add(
        DiagnosticsProperty<TextStyle?>(
          'styleDeactivated',
          styleDeactivated,
        ),
      );
  }
}
