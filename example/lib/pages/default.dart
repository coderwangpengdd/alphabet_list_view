/*
 * @Author: 王鹏 peng.wang@bigmarker.com
 * @Date: 2025-04-21 14:46:32
 * @LastEditors: 王鹏 peng.wang@bigmarker.com
 * @LastEditTime: 2025-04-22 20:55:36
 * @FilePath: /example/lib/pages/default.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';

class ExampleDefault extends StatelessWidget {
  const ExampleDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24),
      child: AlphabetListView(
        items: _animals,
        top: 25,
        options: AlphabetListViewOptions(
            scrollbarOptions: ScrollbarOptions(width: 44, symbols: [
          "A",
          "B",
          "C",
          "D",
          "E",
          "F",
          "G",
          "H",
          "I",
          "J",
          "K",
          "L",
          "M",
          "N",
          "O",
          "P",
          "Q",
          "R",
          "S",
          "T",
          "U",
          "V",
          "W",
          "X",
          "Y",
          "Z"
        ])),
      ),
    );
  }

  List<AlphabetListViewItemGroup> get _animals =>
      Repository.animals.entries.map(
        (animalLetter) {
          debugPrint(animalLetter.key);
          return AlphabetListViewItemGroup(
            tag: animalLetter.key,
            children: animalLetter.value.map(Text.new),
          );
        },
      ).toList();
}
