import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nxtt_wallet/pages/m_y_card/m_y_card_widget.dart';

class CardDetail extends StatefulWidget {
  final MockData item;
  const CardDetail({super.key, required this.item});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  final mockData = [
    {
      'title': 'In 0.00000546',
      'from': 'From: 19rfrE36J7mpfG...mE5SdVvc',
      'to': '',
      'time': '2024-07-13 14:16',
      'color': Colors.green,
    },
    {
      'title': 'In 0.00000546',
      'from': 'From: 19rfrE36J7mpfG...mE5SdVvc',
      'to': '',
      'time': '2024-07-07 11:21',
      'color': Colors.green,
    },
    {
      'title': 'Out 0.00000546',
      'from': 'To:19rfrE36J7mpfG...mE5SdVvc',
      'to': 'Miner\'s fee: 0.00018 BTC',
      'time': '2024-07-07 11:18',
      'color': Colors.redAccent,
    },
    {
      'title': 'Out 0.000063',
      'from': 'To:3G8ybwWtXYG2wS....U4YAGP4R',
      'to': 'Miner\'s fee: 0.0001575 BTC',
      'time': '2024-06-29 15:58',
      'color': Colors.redAccent,
    },
    {
      'title': 'In 0.00000546',
      'from': 'To:1DeBBParK96qUB..W4n5cjaf',
      'to': 'Miner\'s fee: 0.00018 BTC',
      'time': '2024-06-17 16:48',
      'color': Colors.redAccent,
    },
    {
      'title': 'Self 0.04',
      'from': 'Miner\'s fee: 0.0002604 BTC',
      'to': '',
      'time': '2024-05-10 03:20',
      'color': Color(0xff8cb0ba),
    },
    {
      'title': 'Self 0.0185',
      'from': 'Miner\'s fee:0.0000356 BTC',
      'to': '',
      'time': '2024-05-09 19:21',
      'color': Color(0xff8cb0ba),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF2d2d30),
          Colors.black,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.transparent,
          title: Text('HD Wallet My B-Wallet',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.transparent,
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Container(
      color: Color(0xff2d2f3a),
      child: Column(
        children: [
          _buildHeader(),
          _buildList(),
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff363740),
        border: Border.all(color: Color(0xff6e7168)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                widget.item.icon,
                width: 50,
                height: 50,
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
                          widget.item.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                        Text(
                          widget.item.value,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withAlpha(200)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.item.description,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withAlpha(150)),
                        )),
                        Text(
                          widget.item.approximately,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withAlpha(150)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      if (widget.item.name == 'BTC') {
                        context.pushNamed('BTCreceipt');
                      } else if (widget.item.name == 'ETH') {
                        context.pushNamed('ETHreceipt');
                      } else if (widget.item.name == 'USDT') {
                        context.pushNamed('USDTreceipt');
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0))),
                      side: MaterialStateProperty.all(BorderSide(
                        color: Color(0xffe9c387),
                      )),
                    ),
                    child: Text(
                      'Receipt',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FilledButton(
                    onPressed: () {
                      if (widget.item.name == 'BTC') {
                        context.pushNamed('BTCreceipt');
                      } else if (widget.item.name == 'ETH') {
                        context.pushNamed('ETHreceipt');
                      } else if (widget.item.name == 'USDT') {
                        context.pushNamed('USDTreceipt');
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xffe9c387),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  goQrCode() {
    if (widget.item.name == 'BTC') {
      context.pushNamed('BTCqrcode');
    } else if (widget.item.name == 'ETH') {
      context.pushNamed('ETHqrcode');
    } else if (widget.item.name == 'USDT') {
      context.pushNamed('USDTqrcode');
    }
  }

  _buildList() {
    if (widget.item.name == 'BTC') {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) => _buildItem(index),
          padding: EdgeInsets.zero,
          itemCount: mockData.length,
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Container(
            child: Text(
              'empty',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  _buildItem(int index) {
    final item = mockData[index];
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff363740),
        border: Border.all(color: Color(0xff6e7168)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text(
                    item['title']!.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: item['color'] as Color),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
              Icon(
                Icons.check_circle_sharp,
                color: Colors.blue,
                size: 20,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                maxLines: 2,
                item['from']!.toString(),
                style:
                    TextStyle(fontSize: 14, color: Colors.white.withAlpha(150)),
              )),
              Text(
                item['time']!.toString(),
                style:
                    TextStyle(fontSize: 14, color: Colors.white.withAlpha(150)),
              ),
            ],
          ),
          if (item['to'] != '')
            Row(
              children: [
                Expanded(
                    child: Text(
                  item['to']!.toString(),
                  style: TextStyle(
                      fontSize: 14, color: Colors.white.withAlpha(150)),
                )),
              ],
            ),
        ],
      ),
    );
  }
}
