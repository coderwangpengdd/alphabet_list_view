import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// AlphabetScrollBar
class AlphabetScrollbar extends StatefulWidget {
  /// Constructor of AlphabetScrollbar
  const AlphabetScrollbar({
    required this.items,
    required this.symbolChangeNotifierScrollbar,
    required this.symbolChangeNotifierList,
    this.top = 0,
    super.key,
    this.fontFamily,
    this.fontSize = 10,
    this.alphabetScrollbarOptions = const ScrollbarOptions(),
  });

  final String? fontFamily;

  final double? fontSize;

  final double? top;

  /// List of Groups
  final List<AlphabetListViewItemGroup> items;

  /// Scrollbar options
  final ScrollbarOptions alphabetScrollbarOptions;

  /// ChangeNotifier for scrollbar
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;

  /// ChangeNotifier for list
  final SymbolChangeNotifier symbolChangeNotifierList;

  @override
  State<AlphabetScrollbar> createState() => _AlphabetScrollbarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<AlphabetListViewItemGroup>('items', items))
      ..add(
        DiagnosticsProperty<ScrollbarOptions>(
          'alphabetScrollbarOptions',
          alphabetScrollbarOptions,
        ),
      )
      ..add(
        DiagnosticsProperty<SymbolChangeNotifier>(
          'symbolChangeNotifierScrollbar',
          symbolChangeNotifierScrollbar,
        ),
      )
      ..add(
        DiagnosticsProperty<SymbolChangeNotifier>(
          'symbolChangeNotifierList',
          symbolChangeNotifierList,
        ),
      );
  }
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  String? _selectedSymbol;
  late Map<String, GlobalKey> _symbolKeys;
  late List<String> _uniqueItems;

  @override
  void initState() {
    super.initState();
    _uniqueItems = widget.alphabetScrollbarOptions.symbols.toSet().toList();
    _symbolKeys = {
      for (final symbol in _uniqueItems) symbol: GlobalKey(),
    };
    widget.symbolChangeNotifierList
        .addListener(_symbolChangeNotifierListListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.alphabetScrollbarOptions.decoration,
      padding: widget.alphabetScrollbarOptions.padding ?? EdgeInsets.zero,
      color: widget.alphabetScrollbarOptions.backgroundColor,
      width: widget.alphabetScrollbarOptions.width,
      margin: EdgeInsets.only(top: widget.top ?? 0),
      child: Semantics(
        explicitChildNodes: true,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: _pointerMoveEventHandler,
          // onPointerDown: _pointerDownEventHandler,
          child: Column(
            mainAxisAlignment:
                widget.alphabetScrollbarOptions.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: _uniqueItems
                .map(
                  (symbol) => Semantics(
                    button: true,
                    child: GestureDetector(
                      onTap: () {
                        if (symbol != null) {
                          _onSymbolTriggered(symbol);
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.only(left: 8, right: 24),
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          width: 12,
                          key: _symbolKeys[symbol],
                          child: widget.alphabetScrollbarOptions.symbolBuilder
                                  ?.call(
                                context,
                                symbol,
                                _getSymbolState(symbol),
                              ) ??
                              DefaultScrollbarSymbol(
                                symbol: symbol,
                                fontFamily: widget.fontFamily,
                                fontSize: widget.fontSize,
                                state: _getSymbolState(symbol),
                              ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AlphabetScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _uniqueItems = widget.alphabetScrollbarOptions.symbols.toSet().toList();
    _symbolKeys = {
      for (final symbol in _uniqueItems) symbol: GlobalKey(),
    };
  }

  @override
  void dispose() {
    widget.symbolChangeNotifierList
        .removeListener(_symbolChangeNotifierListListener);
    super.dispose();
  }

  AlphabetScrollbarItemState _getSymbolState(String symbol) {
    final Iterable<AlphabetListViewItemGroup> result =
        widget.items.where((item) => item.tag == symbol);
    if (result.isNotEmpty) {
      if ((result.first.childrenDelegate.estimatedChildCount ?? 0) == 0) {
        return AlphabetScrollbarItemState.deactivated;
      } else if (result.first.tag == _selectedSymbol) {
        return AlphabetScrollbarItemState.active;
      } else {
        return AlphabetScrollbarItemState.inactive;
      }
    } else {
      return AlphabetScrollbarItemState.deactivated;
    }
  }

  void _symbolChangeNotifierListListener() {
    setState(
      () => _selectedSymbol =
          widget.symbolChangeNotifierList.value ?? _selectedSymbol,
    );
  }

  void _pointerMoveEventHandler(PointerEvent event) {
    final String? symbol = _identifyTouchedSymbol(event, _symbolKeys);
    if (symbol != null) {
      _onSymbolTriggered(symbol);
    }
  }

  // void _pointerDownEventHandler(PointerEvent event) {
  //   final String? symbol = _identifyTouchedSymbol(event, _symbolKeys);
  //   debugPrint("点击 ：${symbol}");
  //   if (symbol != null) {
  //     _onSymbolTriggered(symbol);
  //   }
  // }

  String? _identifyTouchedSymbol(
    PointerEvent details,
    Map<String, GlobalKey> symbolKeys,
  ) {
    String? touchedSymbol;

    final result = BoxHitTestResult();
    for (final entry in symbolKeys.entries) {
      try {
        final RenderBox? renderBox =
            entry.value.currentContext?.findRenderObject() as RenderBox?;
        final Offset? localLocation =
            renderBox?.globalToLocal(details.position);

        if (localLocation != null &&
            renderBox != null &&
            renderBox.hitTest(result, position: localLocation)) {
          touchedSymbol = entry.key;
          break;
        }
      } on Exception catch (_) {}
    }
    return touchedSymbol;
  }

  void _onSymbolTriggered(String symbol) {
    Iterable<AlphabetListViewItemGroup> result =
        widget.items.where((item) => item.tag == symbol);

    if (!widget.alphabetScrollbarOptions.jumpToSymbolsWithNoEntries) {
      result = result.where(
        (item) => (item.childrenDelegate.estimatedChildCount ?? 0) > 0,
      );
    }
    debugPrint("结果： ${result}");
    if (result.isNotEmpty) {
      widget.symbolChangeNotifierScrollbar.value = symbol;
      setState(() => _selectedSymbol = symbol);
    }
  }
}
