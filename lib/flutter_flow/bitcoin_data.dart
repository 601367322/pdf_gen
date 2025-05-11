class BitcoinData {
  final String priceUsd;
  final int time;
  final String number;
  final String startBalance;
  BitcoinData({required this.priceUsd, required this.time, required this.number, required this.startBalance});

  // 工厂构造函数，用于从 JSON 中解析数据
  factory BitcoinData.fromJson(Map<String, dynamic> json) {
    return BitcoinData(
      number: json['number'],
      priceUsd: json['priceUsd'],
      time: json['time'],
      startBalance: json['start_balance'],
    );
  }
}