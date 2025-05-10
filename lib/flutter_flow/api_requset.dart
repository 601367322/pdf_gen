import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nxtt_wallet/flutter_flow/bitcoin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nxtt_wallet/pages/m_y_card/m_y_card_widget.dart';
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
    if (coins.containsKey(email)) {
      String priceUsd =
          (double.parse(coins[email]!["coins"].toString()) * bitcoin)
              .toStringAsFixed(2)
              .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match match) => '${match[1]},');
      String priceUsd2 =
          (double.parse(coins[email]!["coins"].toString()) * bitcoin_yesterday)
              .toStringAsFixed(2)
              .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match match) => '${match[1]},');
      data = [
        {
          "priceUsd": priceUsd,
          "time": DateTime.now().millisecondsSinceEpoch,
          "number": coins[email]!["coins"].toString()
        },
        {
          "priceUsd": priceUsd2,
          "time":
              DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
          "number": coins[email]!["coins"].toString()
        },
      ];
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
