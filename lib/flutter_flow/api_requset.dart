import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nxtt_wallet/flutter_flow/bitcoin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BitcoinApi {
  static Future<List<BitcoinData>> fetchBitcoinHistory(
      DateTime startDateSelected, DateTime endDateSelected) async {
         List<BitcoinData> bitcoinList = [];

    startDateSelected = DateTime(startDateSelected.year, startDateSelected.month, startDateSelected.day);

    ////测试数据
    // var data = [
    //     {
    //       "priceUsd": "84710.2990925394714345",
    //       "time": 1741046400000,
    //       "date": "2025-03-04T00:00:00.000Z"
    //     },
    //     {
    //       "priceUsd": "88696.6820415918272818",
    //       "time": 1741132800000,
    //       "date": "2025-03-05T00:00:00.000Z"
    //     },
    //     {
    //       "priceUsd": "90544.8105914688930779",
    //       "time": 1741219200000,
    //       "date": "2025-03-06T00:00:00.000Z"
    //     },
    //     {
    //       "priceUsd": "88054.3611483335331366",
    //       "time": 1741305600000,
    //       "date": "2025-03-07T00:00:00.000Z"
    //     },
    //     {
    //       "priceUsd": "86200.6929262576152838",
    //       "time": 1741392000000,
    //       "date": "2025-03-08T00:00:00.000Z"
    //     },
    //     {
    //       "priceUsd": "84387.2463997152197322",
    //       "time": 1741478400000,
    //       "date": "2025-03-09T00:00:00.000Z"
    //     }
    //   ];
    // data.forEach((element) {
    //   bitcoinList.add(BitcoinData.fromJson(element));
    // });
    // return bitcoinList;
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
