import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nxtt_wallet/flutter_flow/bitcoin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BitcoinApi {
  static Future<List<BitcoinData>> fetchBitcoinHistory(
      DateTime startDateSelected, DateTime endDateSelected) async {
    List<BitcoinData> bitcoinList = [];

    startDateSelected = DateTime(
        startDateSelected.year, startDateSelected.month, startDateSelected.day);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    ////测试数据
    var data = [];
    if (email != null) {
      if (email == 'oliver00711@163.com') {
        data = [
          {
            "priceUsd": "31,255,237.58",
            "time": DateTime.now().millisecondsSinceEpoch,
            "number": "333.00203054"
          },
          {
            "priceUsd": "27,499,973.69",
            "time": DateTime.now()
                .subtract(Duration(days: 1))
                .millisecondsSinceEpoch,
            "number": "333.00203054"
          },
        ];
      } else if (email == 'lucas19951@163.com') {
        data = [
          {
            "priceUsd": "46,947,782.99",
            "time": DateTime.now().millisecondsSinceEpoch,
            "number": "500.19479210"
          },
          {
            "priceUsd": "41,307,086.32",
            "time": DateTime.now()
                .subtract(Duration(days: 1))
                .millisecondsSinceEpoch,
            "number": "500.19479210"
          },
        ];
      } else if (email == 'emma2026@tutamail.com') {
        data = [
          {
            "priceUsd": "469,295.218.56",
            "time": DateTime.now().millisecondsSinceEpoch,
            "number": "5000.00023285"
          },
          {
            "priceUsd": "412,910,192,30",
            "time": DateTime.now()
                .subtract(Duration(days: 1))
                .millisecondsSinceEpoch,
            "number": "5000.00023285"
          },
        ];
      }
      data.forEach((element) {
        bitcoinList.add(BitcoinData.fromJson(element));
      });
      return bitcoinList;
    }

    int startTimestamp = startDateSelected.millisecondsSinceEpoch;
    int endTimestamp = endDateSelected.millisecondsSinceEpoch;
    EasyLoading.show(status: 'Downloading...'); // 显示加载动画
    final response = await http.get(Uri.parse(
        'https://api.coincap.io/v2/assets/bitcoin/history?interval=d1&start=$startTimestamp&end=$endTimestamp'));

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Data Loaded'); // 成功时的提示
      // 解析 JSON 数据
      final data = json.decode(response.body)['data'];
      List<BitcoinData> bitcoinList = [];

      for (var item in data) {
        bitcoinList.add(BitcoinData.fromJson(item));
      }
      return bitcoinList;
    } else {
      EasyLoading.showError('Failed to load Bitcoin data');
      throw Exception('Failed to load Bitcoin data');
    }
  }
}
