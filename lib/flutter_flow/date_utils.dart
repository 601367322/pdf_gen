import 'package:flutter/material.dart';


class DateSelectionPage {
  // 静态方法，直接通过类名调用
  static bool isDateRangeValid(BuildContext context, DateTime? startDateSelected, DateTime? endDateSelected) {
    if (startDateSelected != null && endDateSelected != null) {
      int differenceInDays = endDateSelected.difference(startDateSelected).inDays;
      if (differenceInDays >= 15) {
        // 弹出提示框
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("时间跨度太长"),
              content: Text("请重新选择15天内时间跨度"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 关闭对话框
                  },
                  child: Text("确定"),
                ),
              ],
            );
          },
        );
        return false; // 时间跨度太长
      } else {
        return true; // 日期选择有效
      }
    } else {
      return false; // 日期为空时返回 false
    }
  }
}
