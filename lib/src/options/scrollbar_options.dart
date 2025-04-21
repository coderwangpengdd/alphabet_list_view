/*
 * @Author: 王鹏 peng.wang@bigmarker.com
 * @Date: 2025-04-21 14:46:32
 * @LastEditors: 王鹏 peng.wang@bigmarker.com
 * @LastEditTime: 2025-04-21 15:29:24
 * @FilePath: /example/Users/wangxiaoying/Desktop/bigmarker/alphabet_list_view/lib/src/options/scrollbar_options.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

/// Options for the scrollbar of the AlphabetListView
class ScrollbarOptions {
  /// Constructor of ScrollbarOptions
  const ScrollbarOptions({
    this.width = 40,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.backgroundColor,
    this.symbols = DefaultScrollbarSymbols.alphabet,
    this.jumpToSymbolsWithNoEntries = false,
    this.forcePosition,
    this.symbolBuilder,
    this.decoration,
  }) : assert(
          backgroundColor == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        );

  /// The width of the sidebar.
  final double width;

  /// Padding around the sidebar.
  final EdgeInsets? padding;

  /// Placement of the children in the sidebar.
  final MainAxisAlignment mainAxisAlignment;

  /// Optional background color for the sidebar.
  final Color? backgroundColor;

  /// A [List] of [String] representing the symbols to be shown.
  ///
  /// Strings must be unique.
  final Iterable<String> symbols;

  /// Activates symbols without children.
  ///
  /// Enables jumping to the position even if there are no entries present.
  final bool jumpToSymbolsWithNoEntries;

  /// Force the position of the sidebar.
  ///
  /// If set, [Directionality] will be ignored.
  final AlphabetScrollbarPosition? forcePosition;

  /// Builder function for sidebar symbols.
  final SymbolStateBuilder? symbolBuilder;

  /// Decoration for the sidebar.
  final Decoration? decoration;
}
