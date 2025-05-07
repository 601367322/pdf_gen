import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime getFirstOfMonth() {
  // returns the first of the month
  return DateTime(DateTime.now().year, DateTime.now().month, 1);
}

DateTime? getCustomDateRange(String? rangeType) {
  DateTime getCustomDateRange(String rangeType) {
    // 获取当前日期
    DateTime now = DateTime.now();

    // 根据 rangeType 参数返回对应的日期
    switch (rangeType) {
      case '7_days': // 返回过去 7 天的日期
        return now.subtract(Duration(days: 7));
      case '30_days': // 返回过去 30 天的日期
        return now.subtract(Duration(days: 30));
      case '365_days': // 返回过去一年的日期
        return now.subtract(Duration(days: 365));
      default: // 如果没有传递正确的参数，返回当前日期
        return now;
    }
  }
}
