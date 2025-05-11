import 'package:dio/dio.dart';
import 'package:nxtt_wallet/pages/m_y_card/card_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'm_y_card_model.dart';
export 'm_y_card_model.dart';

var bitcoin = 0.0;
var bitcoin_yesterday = 0.0;

const coins = {
  "oliver00711@163.com": {
    "coins": 333.00203054,
    "address": "1F7W7KUCyFq4aLe5S54susKsKATWxu5W1U",
    "qrcode": "assets/images/333_qrcode.png",
    "start_balance": '31,255,237.58'
  },
  "lucas19951@163.com": {
    "coins": 500.19479210,
    "address": "1Fb8G86EjJnWaFxR8564gnMXyFxAgFH7Jr",
    "qrcode": "assets/images/500_qrcode.png",
    "start_balance": '46,947,782.99'
  },
  "emma2026@tutamail.com": {
    "coins": 5000.00023285,
    "address": "bc1q0j357l7jdfuzuyjpwvx0s3cujvmkeunxdkzzju",
    "qrcode": "assets/images/5000_qrcode.png",
    "start_balance": '469,295,218.56'
  },
};

class MockData {
  late String icon;
  late String name;
  late String description;
  late String value;
  late String approximately;

  MockData.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
    approximately = json['approximately'];
  }

  toJson() {
    return {
      'icon': icon,
      'name': name,
      'description': description,
      'value': value,
      'approximately': approximately,
    };
  }

  MockData(
      {required this.icon,
      required this.name,
      required this.description,
      required this.value,
      required this.approximately});

  static Future<List<MockData>> generateMockData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email') ?? '';
    var _mockData = mockData;
    if (coins.containsKey(email)) {
      _mockData[0].value = coins[email]!["coins"].toString();
      _mockData[0].approximately =
          '≈\$${(double.parse(_mockData[0].value) * bitcoin).toStringAsFixed(6)}(USD)';
    }
    return _mockData;
  }

  static List<MockData> mockData = [
    MockData(
        icon: "assets/images/btc2@2x.png",
        name: "BTC",
        description: "Bitcoin",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/eth2@2x.png",
        name: "ETH",
        description: "Ethereum",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/tether2@2x.png",
        name: "USDT",
        description: "Tether",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/xrp2@2x.png",
        name: "XRP",
        description: "XRP",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/bnb3@2x.png",
        name: "BNB",
        description: "BNB",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/sol2@2x.png",
        name: "SOL",
        description: "Solana",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
    MockData(
        icon: "assets/images/usdc3@2x.png",
        name: "USDC",
        description: "USDC",
        value: "0.00",
        approximately: "≈\$0.00(USD)"),
  ];
}

class MYCardWidget extends StatefulWidget {
  const MYCardWidget({super.key});

  @override
  State<MYCardWidget> createState() => _MYCardWidgetState();
}

class _MYCardWidgetState extends State<MYCardWidget>
    with TickerProviderStateMixin {
  late MYCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _hideSmallCoins = false;
  bool _hideShowCoins = false;

  List<MockData> _mockData = [];

  final endDrawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MYCardModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    _loadMockData();
    getCoinPrice();
  }

  Future<void> _loadMockData() async {
    _mockData = await MockData.generateMockData();
    setState(() {});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void getCoinPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var todayPrice =
        prefs.getDouble(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    var yesterdayPrice = prefs.getDouble(DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 1))));

    if (todayPrice != null) {
      bitcoin = todayPrice;
    }
    if (yesterdayPrice != null) {
      bitcoin_yesterday = yesterdayPrice;
    }

    _loadMockData();

    if (todayPrice == null) {
      Dio()
          .get(
              'https://tsanghi.com/api/fin/crypto/realtime?token=demo&ticker=BTC/USD&exchange_code=Binance')
          .then((response) {
        bitcoin = response.data['data'][0]['close'];
        bitcoin_yesterday = response.data['data'][0]['open'];

        prefs.setDouble(
            DateFormat('yyyy-MM-dd').format(DateTime.now()), bitcoin);
        prefs.setDouble(
            DateFormat('yyyy-MM-dd')
                .format(DateTime.now().subtract(Duration(days: 1))),
            bitcoin_yesterday);

        _loadMockData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_mockData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      key: endDrawerKey,
      backgroundColor: Color(0xff2e2f3a),
      body: Column(
        children: [
          _buildHeader(),
          _buildBody(),
        ],
      ),
      endDrawer: Container(
        color: Color(0xff2e2f3a),
        width: MediaQuery.of(context).size.width * 0.5,
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context.pushNamed('AccountStatement');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.white,),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(FFLocalizations.of(context).getText('download statement'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, bottom: 20),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF2d2d30),
          Colors.black,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  endDrawerKey.currentState?.openEndDrawer();
                },
                icon: Image.asset('assets/images/more_icon.png', width: 24, height: 24,),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "My B-Wallet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "total assets (USD)",
              style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _hideShowCoins
                        ? "*.**"
                        : (double.parse(_mockData[0].value) * bitcoin)
                            .toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match match) => '${match[1]},'),
                    style: const TextStyle(
                        color: Color(0xffc0aa82),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    hideShowCoins();
                  },
                  child: Icon(
                    _hideShowCoins
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    hideSmallCoins();
                  },
                  child: Icon(
                    _hideSmallCoins
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Hide small coins",
                  style: TextStyle(
                      color: Colors.white.withAlpha(200), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  hideSmallCoins() {
    setState(() {
      _hideSmallCoins = !_hideSmallCoins;
    });
  }

  hideShowCoins() {
    setState(() {
      _hideShowCoins = !_hideShowCoins;
    });
  }

  _buildBody() {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _hideSmallCoins ? 3 : _mockData.length,
        itemBuilder: (context, index) => _buildItem(_mockData[index]),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xff4c4d56),
        ),
      ),
    );
  }

  _buildItem(MockData item) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CardDetail(item: item)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: ClipOval(
                child: Image.asset(
                  item.icon,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      Text(
                        _hideShowCoins ? "*.**" : item.value,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Expanded(
                        child: Text(
                      item.description,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff777780)),
                    )),
                    Text(
                      _hideShowCoins ? "*.**" : item.approximately,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff777780)),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
