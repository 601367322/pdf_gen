import 'package:dio/dio.dart';
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
      // 在这里声明变量，确保它们在整个方法中都可访问
      double startBalance = 0;
      double endBalance = 0;

      var headers = {
        'accept': 'application/json',
        'x-cg-pro-api-key': 'CG-t6BivKvsGSeZfqZyyLRicvfg'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d&endTime=${endDateSelected.millisecondsSinceEpoch}&startTime=${startDateSelected.millisecondsSinceEpoch}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        // print(json.encode(response.data));
        // 根据startDateSelected和endDateSelected获取response中的data，然后计算start_balance、end_balance
        
        if (response.data != null && response.data.isNotEmpty) {
          // 获取开始日期的数据（第一个数据点）
          var startData = response.data.firstWhere(
            (item) {
              DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item[0]);
              return itemDate.year == startDateSelected.year && 
                     itemDate.month == startDateSelected.month && 
                     itemDate.day == startDateSelected.day;
            },
            orElse: () => response.data.first,
          );
          
          // 获取结束日期的数据（最后一个数据点）
          var endData = response.data.lastWhere(
            (item) {
              DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item[6]);
              return itemDate.year == endDateSelected.year && 
                     itemDate.month == endDateSelected.month && 
                     itemDate.day == endDateSelected.day;
            },
            orElse: () => response.data.last,
          );
          
          // 计算开始余额和结束余额（使用收盘价）
          if (startData != null && startData.length > 4) {
            startBalance = double.parse(startData[1]) * double.parse(coins[email]!["coins"].toString());
          }
          
          if (endData != null && endData.length > 4) {
            endBalance = double.parse(endData[4]) * double.parse(coins[email]!["coins"].toString());
          }
        }
      } else {
        print(response.statusMessage);
      }

      data = [
        {
          "time": DateTime.now().millisecondsSinceEpoch,
          "number": coins[email]!["coins"].toString(),
          "start_balance": startBalance.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),(Match match) => '${match[1]},'),
          "end_balance": endBalance.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),(Match match) => '${match[1]},'),
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
