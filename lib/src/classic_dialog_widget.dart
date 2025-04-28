import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

///Single selection callback of list dialog
typedef OnSingleSelectionCallback = void Function(int selectedIndex);

///Multiple selection callback of list dialog
typedef OnMultiSelectionCallback = void Function(List<int> selectedIndexes);

///
///created time: 2019-07-31 09:35
///author linzhiliang
///version 1.0
///since
///file name: classic_dialog_widget.dart
///description: General dialog
///
@immutable
class ClassicGeneralDialogWidget extends StatelessWidget {
  ///Title text of the dialog
  final String titleText;

  ///Content text of the dialog
  final String contentText;

  ///Text of negative button, the left button at the bottom of dialog
  final String negativeText;

  ///Text of positive button, the right button at the bottom of dialog
  final String positiveText;

  ///TextStyle of negative button, the left button at the bottom of dialog
  final TextStyle negativeTextStyle;

  ///TextStyle of positive button, the right button at the bottom of dialog
  final TextStyle positiveTextStyle;

  ///Click callback of negative button
  final VoidCallback onNegativeClick;

  ///Click callback of positive button
  final VoidCallback onPositiveClick;

  ///Actions at the bottom of dialog, when this is set, [negativeText] [positiveText] [onNegativeClick] [onPositiveClick] will not work。
  final List<Widget> actions;

  ClassicGeneralDialogWidget({
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
    // TODO: implement build
    return CustomDialogWidget(
      title: titleText != null
          ? Text(
              titleText,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      content: contentText != null
          ? Text(
              contentText,
              style: Theme.of(context).dialogTheme.contentTextStyle,
            )
          : null,
      actions: actions ??
          [
            onNegativeClick != null
                ? FlatButton(
                    onPressed: onNegativeClick,
                    splashColor: Theme.of(context).splashColor,
                    highlightColor: Theme.of(context).highlightColor,
                    child: Text(
                      negativeText ?? 'cancel',
                      style: negativeTextStyle ??
                          TextStyle(
                              color: Theme.of(context).textTheme.overline.color,
                              fontSize:
                                  Theme.of(context).textTheme.button.fontSize),
                    ),
                  )
                : null,
            onPositiveClick != null
                ? FlatButton(
                    onPressed: onPositiveClick,
                    splashColor: Theme.of(context).splashColor,
                    highlightColor: Theme.of(context).highlightColor,
                    child: Text(
                      positiveText ?? 'confirm',
                      style: positiveTextStyle ??
                          TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize:
                                  Theme.of(context).textTheme.button.fontSize),
                    ),
                  )
                : null,
          ],
      elevation: 0.0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}

///List type
enum ListType {
  ///Single
  single,

  ///Single select
  singleSelect,

  ///Multiple select
  multiSelect,
}

///
///created time: 2019-08-01 08:59
///author linzhiliang
///version 1.0
///since
///file name: classic_dialog_widget.dart
///description: Classic dialog with list content
///
@immutable
class ClassicGeneralDialogWidget extends StatelessWidget {
  /// Title text of the dialog
  final String? titleText; // Made nullable

  /// Content text of the dialog
  final String? contentText; // Made nullable

  /// Text of negative button, the left button at the bottom of dialog
  final String? negativeText; // Made nullable

  /// Text of positive button, the right button at the bottom of dialog
  final String? positiveText; // Made nullable

  /// TextStyle of negative button, the left button at the bottom of dialog
  final TextStyle? negativeTextStyle; // Already nullable

  /// TextStyle of positive button, the right button at the bottom of dialog
  final TextStyle? positiveTextStyle; // Already nullable

  /// Click callback of negative button
  final VoidCallback? onNegativeClick; // Already nullable

  /// Click callback of positive button
  final VoidCallback? onPositiveClick; // Already nullable

  /// Actions at the bottom of dialog
  final List<Widget>? actions; // Already nullable

  const ClassicGeneralDialogWidget({
    this.titleText,
    this.contentText,
    this.actions,
    this.negativeText,
    this.positiveText,
    this.negativeTextStyle,
    this.positiveTextStyle,
    this.onNegativeClick,
    this.onPositiveClick,
    Key? key,
  }) : super(key: key);

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
              TextButton( // Updated to TextButton (FlatButton is deprecated)
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
              TextButton( // Updated to TextButton
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
          ].where((e) => e != null).toList(),
      elevation: 0.0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}

class ClassicListDialogWidgetState<T> extends State<ClassicListDialogWidget> {
  int selectedIndex;
  List<bool> valueList;
  List<int> selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    valueList = List.generate(widget.dataList.length, (index) {
      if (widget.selectedIndexes != null &&
          widget.selectedIndexes.contains(index)) {
        return true;
      }
      return false;
    }).toList(growable: true);
    selectedIndex = widget.selectedIndex;
    selectedIndexes = widget.selectedIndexes;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget contentWidget;
    if (widget.dataList != null) {
      contentWidget = ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (widget.listItem == null) {
            switch (widget.listType) {
              case ListType.single:
                return ListTile(
                  title: Text(
                    widget.dataList[index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onTap: widget.onListItemClick ??
                      () {
                        Navigator.of(context).pop(index);
                      },
                );
                break;
              case ListType.singleSelect:
                return RadioListTile<int>(
                  controlAffinity: widget.controlAffinity,
                  title: Text(
                    widget.dataList[index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  activeColor:
                      widget.activeColor ?? Theme.of(context).primaryColor,
                  value: index,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                );
                break;
              case ListType.multiSelect:
                return CheckboxListTile(
                  controlAffinity: widget.controlAffinity,
                  selected: valueList[index],
                  value: valueList[index],
                  title: Text(
                    widget.dataList[index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onChanged: (value) {
                    setState(() {
                      valueList[index] = value;
                    });
                  },
                  activeColor:
                      widget.activeColor ?? Theme.of(context).primaryColor,
                );
                break;
              default:
                return ListTile(
                  title: Text(
                    widget.dataList[index].toString(),
                    style: Theme.of(context).dialogTheme.contentTextStyle,
                  ),
                  onTap: widget.onListItemClick ??
                      () {
                        Navigator.of(context).pop(index);
                      },
                );
                break;
            }
          } else {
            return widget.listItem;
          }
        },
        itemCount: widget.dataList.length,
      );
      contentWidget = Container(
        width: double.maxFinite,
        child: contentWidget,
      );
    } else {}

    return CustomDialogWidget(
      title: widget.titleText != null
          ? Text(
              widget.titleText,
              style: Theme.of(context).dialogTheme.titleTextStyle,
            )
          : null,
      contentPadding: EdgeInsets.all(0.0),
      content: contentWidget,
      actions: widget.actions ??
          [
            widget.onNegativeClick != null
                ? FlatButton(
                    onPressed: widget.onNegativeClick,
                    splashColor: Theme.of(context).splashColor,
                    highlightColor: Theme.of(context).highlightColor,
                    child: Text(
                      widget.negativeText ?? 'cancel',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.overline.color,
                          fontSize:
                              Theme.of(context).textTheme.button.fontSize),
                    ),
                  )
                : null,
            FlatButton(
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
                        int length = valueList.length;
                        for (int i = 0; i < length; i++) {
                          if (valueList[i]) {
                            selectedIndexes.add(i);
                          }
                        }
                        Navigator.of(context).pop(selectedIndexes);
                        break;
                    }
                  },
              splashColor: Theme.of(context).splashColor,
              highlightColor: Theme.of(context).highlightColor,
              child: Text(
                widget.positiveText ?? 'confirm',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Theme.of(context).textTheme.button.fontSize),
              ),
            ),
          ],
      elevation: 0.0,
      shape: Theme.of(context).dialogTheme.shape,
    );
  }
}
