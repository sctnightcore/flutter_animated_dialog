import 'package:flutter/material.dart';

/// Single selection callback of list dialog
typedef OnSingleSelectionCallback = void Function(int selectedIndex);

/// Multiple selection callback of list dialog
typedef OnMultiSelectionCallback = void Function(List<int> selectedIndexes);

///
/// created time: 2019-07-31 09:35
/// author: linzhiliang
/// version: 1.0
/// description: General dialog
///
@immutable
class ClassicGeneralDialogWidget extends StatelessWidget {
  /// Title text of the dialog
  final String? titleText;

  /// Content text of the dialog
  final String? contentText;

  /// Text of negative button, the left button at the bottom of dialog
  final String? negativeText;

  /// Text of positive button, the right button at the bottom of dialog
  final String? positiveText;

  /// TextStyle of negative button, the left button at the bottom of dialog
  final TextStyle? negativeTextStyle;

  /// TextStyle of positive button, the right button at the bottom of dialog
  final TextStyle? positiveTextStyle;

  /// Click callback of negative button
  final VoidCallback? onNegativeClick;

  /// Click callback of positive button
  final VoidCallback? onPositiveClick;

  /// Actions at the bottom of dialog
  final List<Widget>? actions;

  const ClassicGeneralDialogWidget({
    super.key,
    this.titleText,
    this.contentText,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.negativeTextStyle,
    this.positiveTextStyle,
    this.onNegativeClick,
    this.onPositiveClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      title: titleText != null
          ? Text(
              titleText!,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      content: contentText != null
          ? Text(
              contentText!,
              style: Theme.of(context).dialogTheme.contentTextStyle,
            )
          : null,
      actions: actions ??
          [
            if (onNegativeClick != null)
              TextButton(
                onPressed: onNegativeClick,
                style: TextButton.styleFrom(
                  splashFactory: Theme.of(context).splashFactory,
                ),
                child: Text(
                  negativeText ?? 'Cancel',
                  style: negativeTextStyle ??
                      TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                      ),
                ),
              ),
            if (onPositiveClick != null)
              TextButton(
                onPressed: onPositiveClick,
                style: TextButton.styleFrom(
                  splashFactory: Theme.of(context).splashFactory,
                ),
                child: Text(
                  positiveText ?? 'Confirm',
                  style: positiveTextStyle ??
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                      ),
                ),
              ),
          ].whereType<Widget>().toList(),
      elevation: 0.0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}

/// List type
enum ListType {
  /// Single
  single,

  /// Single select
  singleSelect,

  /// Multiple select
  multiSelect,
}

///
/// created time: 2019-08-01 08:59
/// author: linzhiliang
/// version: 1.0
/// description: Classic dialog with list content
///
class ClassicListDialogWidget<T> extends StatefulWidget {
  /// Title text of the dialog
  final String? titleText;

  /// Data of the list
  final List<T>? dataList;

  /// Custom list item widget
  final Widget? listItem;

  /// Click callback of default list item
  final VoidCallback? onListItemClick;

  /// List type
  final ListType listType;

  /// Where to place control relative to the text
  final ListTileControlAffinity controlAffinity;

  /// The active color of radio or checkbox
  final Color? activeColor;

  /// Selected indexes when [listType] is [ListType.multiSelect]
  final List<int>? selectedIndexes;

  /// Selected index when [listType] is [ListType.singleSelect]
  final int? selectedIndex;

  /// Text of negative button, the left button at the bottom of dialog
  final String? negativeText;

  /// Text of positive button, the right button at the bottom of dialog
  final String? positiveText;

  /// Click callback of negative button
  final VoidCallback? onNegativeClick;

  /// Click callback of positive button
  final VoidCallback? onPositiveClick;

  /// Actions at the bottom of dialog
  final List<Widget>? actions;

  const ClassicListDialogWidget({
    super.key,
    this.titleText,
    this.dataList,
    this.listItem,
    this.onListItemClick,
    this.listType = ListType.single,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.activeColor,
    this.selectedIndexes,
    this.selectedIndex,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.onNegativeClick,
    this.onPositiveClick,
  });

  @override
  State<ClassicListDialogWidget<T>> createState() => ClassicListDialogWidgetState<T>();
}

class ClassicListDialogWidgetState<T> extends State<ClassicListDialogWidget<T>> {
  int? selectedIndex;
  List<bool>? valueList;
  List<int> selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    if (widget.dataList != null) {
      valueList = List.generate(widget.dataList!.length, (index) {
        return widget.selectedIndexes?.contains(index) ?? false;
      }).toList(growable: true);
    } else {
      valueList = [];
    }
    selectedIndex = widget.selectedIndex;
    selectedIndexes = widget.selectedIndexes?.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    Widget? contentWidget;
    if (widget.dataList != null && widget.dataList!.isNotEmpty) {
      contentWidget = ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (widget.listItem == null) {
            switch (widget.listType) {
              case ListType.single:
                return ListTile(
                  title: Text(
                    widget.dataList![index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onTap: widget.onListItemClick ??
                      () {
                        Navigator.of(context).pop(index);
                      },
                );
              case ListType.singleSelect:
                return RadioListTile<int>(
                  controlAffinity: widget.controlAffinity,
                  title: Text(
                    widget.dataList![index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
                  value: index,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                );
              case ListType.multiSelect:
                return CheckboxListTile(
                  controlAffinity: widget.controlAffinity,
                  selected: valueList![index],
                  value: valueList![index],
                  title: Text(
                    widget.dataList![index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onChanged: (value) {
                    setState(() {
                      valueList![index] = value ?? false;
                    });
                  },
                  activeColor: widget.activeColor ?? Theme.of(context).primaryColor,
                );
              default:
                return ListTile(
                  title: Text(
                    widget.dataList![index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onTap: widget.onListItemClick ??
                      () {
                        Navigator.of(context).pop(index);
                      },
                );
            }
          } else {
            return widget.listItem;
          }
        },
        itemCount: widget.dataList!.length,
      );
      contentWidget = Container(
        width: double.maxFinite,
        child: contentWidget,
      );
    }

    return CustomDialogWidget(
      title: widget.titleText != null
          ? Text(
              widget.titleText!,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      contentPadding: const EdgeInsets.all(0.0),
      content: contentWidget,
      actions: widget.actions ??
          [
            if (widget.onNegativeClick != null)
              TextButton(
                onPressed: widget.onNegativeClick,
                style: TextButton.styleFrom(
                  splashFactory: Theme.of(context).splashFactory,
                ),
                child: Text(
                  widget.negativeText ?? 'Cancel',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                  ),
                ),
              ),
            TextButton(
              onPressed: widget.onPositiveClick ??
                  () {
                    switch (widget.listType) {
                      case ListType.single:
                        Navigator.of(context).pop();
                        break;
                      case ListType.singleSelect:
                        Navigator.of(context).pop(selectedIndex);
                        break;
                      case ListType.multiSelect:
                        selectedIndexes = [];
                        for (int i = 0; i < (valueList?.length ?? 0); i++) {
                          if (valueList![i]) {
                            selectedIndexes.add(i);
                          }
                        }
                        Navigator.of(context).pop(selectedIndexes);
                        break;
                    }
                  },
              style: TextButton.styleFrom(
                splashFactory: Theme.of(context).splashFactory,
              ),
              child: Text(
                widget.positiveText ?? 'Confirm',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                ),
              ),
            ),
          ].whereType<Widget>().toList(),
      elevation: 0.0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}
