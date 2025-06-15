class BitcoinData {
  final int time;
  final String number;
  final String startBalance;
  final String endBalance;
  BitcoinData({required this.time, required this.number, required this.startBalance, required this.endBalance});

  // 工厂构造函数，用于从 JSON 中解析数据
  factory BitcoinData.fromJson(Map<String, dynamic> json) {
    return BitcoinData(
      number: json['number'],
      time: json['time'],
      startBalance: json['start_balance'],
      endBalance: json['end_balance'],
    );
  }
}