class BitcoinData {
  final String priceUsd;
  final int time;
  final String number;

  BitcoinData({required this.priceUsd, required this.time, required this.number});

  // 工厂构造函数，用于从 JSON 中解析数据
  factory BitcoinData.fromJson(Map<String, dynamic> json) {
    return BitcoinData(
      number: json['number'],
      priceUsd: json['priceUsd'],
      time: json['time'],
    );
  }
}