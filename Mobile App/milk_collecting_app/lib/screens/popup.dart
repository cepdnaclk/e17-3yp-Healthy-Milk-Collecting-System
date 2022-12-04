import 'package:flutter/material.dart';
import 'package:popup_window/popup_window.dart';

class PopupWindowBtn extends StatefulWidget {
  @override
  _PopupWindowBtnState createState() => _PopupWindowBtnState();
}

class _PopupWindowBtnState extends State<PopupWindowBtn> {
  bool _autoShowDialog = false;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_autoShowDialog) {
        _autoShowDialog = false;
        PopupWindowButton.of(context).showPopupWindow();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.add);
  }
}