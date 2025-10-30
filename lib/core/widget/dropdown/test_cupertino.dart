import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';

class FruitPickerExample extends ConsumerStatefulWidget {
  const FruitPickerExample({super.key});

  @override
  ConsumerState<FruitPickerExample> createState() => _FruitPickerExampleState();
}

class _FruitPickerExampleState extends ConsumerState<FruitPickerExample> {
  final List<String> fruits = ['Elma', 'Armut', 'Muz', 'Kiraz'];

  // Başlangıçta seçili değer
  String selectedFruit = 'Muz';

  void _showPicker() {
    int initialIndex = fruits.indexOf(selectedFruit);
    if (initialIndex < 0) initialIndex = 0;

    FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialIndex);

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: ColorManager.white,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('İptal'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Tamam'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(height: 0, thickness: 1),
            Expanded(
              child: CupertinoPicker(
                scrollController: scrollController,
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedFruit = fruits[index];
                  });
                },
                children: fruits
                    .map((fruit) => Center(
                          child: Text(
                            fruit,
                            style: context.general.textTheme.titleMedium,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPicker,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.greyColor),
          borderRadius: BorderRadius.circular(12),
          color: ColorManager.white,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          selectedFruit, // Sayfa yüklendiğinde "Muz" görünür
          style: context.general.textTheme.titleMedium,
        ),
      ),
    );
  }
}
