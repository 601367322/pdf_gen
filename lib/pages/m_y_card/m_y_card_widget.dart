import 'package:dio/dio.dart';
import 'package:nxtt_wallet/pages/m_y_card/card_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'm_y_card_model.dart';
export 'm_y_card_model.dart';

var bitcoin = 0.0;

const coins = {
  "oliver00711@163.com": {
    "coins": 333.00203054,
    "address": "722000503",
    "qrcode": "assets/images/333_qrcode.png",
    "btcboxQrcode": "assets/images/btcbox_333_qrcode.png",
  },
  "lucas19951@163.com": {
    "coins": 500.19479210,
    "address": "722000503",
    "qrcode": "assets/images/500_qrcode.png",
    "btcboxQrcode": "assets/images/btcbox_500_qrcode.png",
  },
  "emma2026@tutamail.com": {
    "coins": 5000.00023285,
    "address": "722000503",
    "qrcode": "assets/images/5000_qrcode.png",
    "btcboxQrcode": "assets/images/btcbox_5000_qrcode.png",
  },
  "jckd740@163.com": {
    "coins": 5833.19915123,
    "address": "722000503",
    "qrcode": "assets/images/5000_qrcode.png",
    "btcboxQrcode": "assets/images/btcbox_5000_qrcode.png",
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

    if (todayPrice != null) {
      bitcoin = todayPrice;
    }

    _loadMockData();

    var headers = {
      'accept': 'application/json',
      'x-cg-pro-api-key': 'CG-t6BivKvsGSeZfqZyyLRicvfg'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d&limit=3',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      // 获取结束日期的数据（最后一个数据点）
      var endData = response.data.lastWhere(
        (item) {
          DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(item[6]);
          return itemDate.year == DateTime.now().year &&
              itemDate.month == DateTime.now().month &&
              itemDate.day == DateTime.now().day;
        },
        orElse: () => response.data.last,
      );
      bitcoin = double.parse(endData[4]);

      prefs.setDouble(DateFormat('yyyy-MM-dd').format(DateTime.now()), bitcoin);

      _loadMockData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_mockData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        // 如果没有用户数据，显示加载状态
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xff2e2f3a),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final userRecord = snapshot.data!;

        return Scaffold(
          key: endDrawerKey,
          backgroundColor: Color(0xff2e2f3a),
          body: Column(
            children: [
              _buildHeader(userRecord),
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
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                FFLocalizations.of(context)
                                    .getText('download statement'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildHeader(UsersRecord userRecord) {
    const String appFlavor =
        String.fromEnvironment('APP_FLAVOR', defaultValue: 'bwallet');

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
                icon: Image.asset(
                  'assets/images/more_icon.png',
                  width: 24,
                  height: 24,
                ),
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
                    child: userRecord.photoUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: userRecord.photoUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Center(
                               child: SizedBox(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/avatar.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/avatar.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  appFlavor == 'bwallet' ? "My B-Wallet" : "My Wallet",
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
                        : () {
                            String value = (double.parse(_mockData[0].value) * bitcoin).toStringAsFixed(8);
                            List<String> parts = value.split('.');
                            String intPart = parts[0].replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match match) => '${match[1]},');
                            return "$intPart.${parts[1]}";
                          }(),
                    style: const TextStyle(
                        color: Color(0xffc0aa82),
                        fontSize: 26,
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
