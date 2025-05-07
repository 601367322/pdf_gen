class BitcoinData {
  final String priceUsd;
  final int time;

  BitcoinData({required this.priceUsd, required this.time});

  // 工厂构造函数，用于从 JSON 中解析数据
  factory BitcoinData.fromJson(Map<String, dynamic> json) {
    return BitcoinData(
      priceUsd: json['priceUsd'],
      time: json['time'],
    );
  }
}