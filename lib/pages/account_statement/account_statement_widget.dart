import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nxtt_wallet/flutter_flow/api_requset.dart';
import 'package:nxtt_wallet/flutter_flow/bitcoin_data.dart';
import 'package:nxtt_wallet/flutter_flow/date_utils.dart';
import 'package:pdf/pdf.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'account_statement_model.dart';
export 'account_statement_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AccountStatementWidget extends StatefulWidget {
  const AccountStatementWidget({
    super.key,
  });

  @override
  State<AccountStatementWidget> createState() => _AccountStatementWidgetState();
}

class _AccountStatementWidgetState extends State<AccountStatementWidget>
    with TickerProviderStateMixin {
  late AccountStatementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountStatementModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // 获取本地图片的字节数据
  Future<Uint8List> _loadImage(String path) async {
    final byteData = await rootBundle.load(path); // 从 assets 加载图片
    return byteData.buffer.asUint8List();
  }

  // 生成 PDF 文件的方法
  Future<void> _generateAndDownloadPdf(
      List<BitcoinData> bitcoinData, BuildContext ctx) async {
    final pdf = pw.Document();
    final sloganImageBytes = await _loadImage('assets/images/slogan.jpg');
    final sloganImage = pw.MemoryImage(sloganImageBytes);

    final iconImageBytes = await _loadImage('assets/images/icon_image.jpg');
    final iconImage = pw.MemoryImage(iconImageBytes);

    RegExp regExp = RegExp(r'\(([\d\.]+)\)');
    Match? match = regExp.firstMatch(FFLocalizations.of(ctx).getText(
      'wom3n7zb' /* BTC (5167.00) */,
    ));
    String number = '';
    if (match != null) {
      number = match.group(1)!; // 提取到的数字部分// 输出: 5167.00
    }

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          theme: pw.ThemeData(
            defaultTextStyle: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.normal,
              font: pw.Font.ttf(
                await rootBundle.load('assets/fonts/ayuthaya-webfont.ttf'),
              ),
            ),
          ),
        ),
        build: (pw.Context context) {
          return [
            // First Row: Cryvo-Wallet Logo and Title
            pw.Stack(
              children: [
                pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(sloganImage, height: 50),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('BTC CRYVO WALLET',
                              style: pw.TextStyle(
                                  fontSize: 8,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.SizedBox(height: 10),
                          pw.Text(
                              '${DateFormat('yyyy-MM-dd').format(startDate)} - ${DateFormat('yyyy-MM-dd').format(endDate)}',
                              style: pw.TextStyle(
                                  fontSize: 8,
                                  fontWeight: pw.FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(left: 2, right: 2, top: 8),
                    child: pw.Text(
                      '************************************************************************************************************************************************************************************************'
                      '',
                      maxLines: 2,
                      style: pw.TextStyle(
                          fontSize: 6,
                          letterSpacing: 5,
                          fontWeight: pw.FontWeight.normal,
                          lineSpacing: 2),
                    ),
                  ),
                ]),
                pw.Positioned(
                  right: 0, // 你可以根据需要调整位置
                  top: 0, // 如果需要调整垂直位置
                  child: pw.Image(iconImage, height: 55),
                ),
              ],
            ),
            // Third Row: Wallet Statement and Bitcoin Label
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 5, left: 5, right: 5),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'WALLET STATEMENT',
                    style: pw.TextStyle(
                        fontSize: 11, fontWeight: pw.FontWeight.normal),
                  ),
                  pw.Text(
                    'BITCOIN',
                    style: pw.TextStyle(
                        fontSize: 11, fontWeight: pw.FontWeight.normal),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 2, right: 2, top: 8),
              child: pw.Text(
                '************************************************************************************************************************************************************************************************'
                '',
                maxLines: 2,
                style: pw.TextStyle(
                    fontSize: 6,
                    letterSpacing: 5,
                    fontWeight: pw.FontWeight.normal,
                    lineSpacing: 2),
              ),
            ),
            // Fifth Row: BTC Daily Balance Report
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 2, right: 2),
              child: pw.Column(children: [
                pw.Align(
                  alignment: pw.Alignment.centerLeft, // 左对齐
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'WALLET ADDRESS:',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.normal),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                        '1jddjaj3hfshfh4fhfsh4',
                        style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                            color: const PdfColor.fromInt(0x0000FF)),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Align(
                  alignment: pw.Alignment.centerLeft, // 左对齐
                  child: pw.Text(
                    'STATEMENT PERIOD: ${DateFormat('yyyy-MM-dd').format(startDate)} - ${DateFormat('yyyy-MM-dd').format(endDate)}',
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.normal),
                  ),
                ),
              ]),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              '-------------------------------------------------------------------------------------------------------------------------------------',
              maxLines: 1,
              style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                  letterSpacing: 5),
            ),
            pw.SizedBox(height: 5),
            // Fifth Row: BTC Daily Balance Report
            pw.Align(
              alignment: pw.Alignment.centerLeft, // 左对齐
              child: pw.Text(
                'BTC Daily Balance Report',
                style: pw.TextStyle(
                    fontSize: 10, fontWeight: pw.FontWeight.normal),
              ),
            ),
            pw.SizedBox(height: 10),

            // Sixth Row: Bitcoin Data List
            pw.ListView.builder(
              itemCount: bitcoinData.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.only(top: 6, bottom: 5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom:
                            pw.BorderSide(color: PdfColors.black, width: 0.5),
                      ),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "TIME",
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                          ),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.only(right: 40),
                          child: pw.Text(
                            'AMOUNT (BTC)',
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ),
                        pw.Text(
                          'AMOUNT (USD)',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  );
                }
                final item = bitcoinData[index - 1];
                return pw.Container(
                  padding: const pw.EdgeInsets.only(top: 6, bottom: 5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black, width: 0.5),
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        DateFormat('yyyy-MM-dd').format(
                          DateTime.fromMillisecondsSinceEpoch(item.time),
                        ),
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                      pw.Text(
                        '$number  BTC',
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                      pw.Text(
                        '${item.priceUsd}  USD',
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              '-------------------------------------------------------------------------------------------------------------------------------------',
              maxLines: 1,
              style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                  letterSpacing: 5),
            ),
            pw.SizedBox(height: 10),

            // Seventh Row: Note Header
            pw.Align(
                alignment: pw.Alignment.centerLeft, // 左对齐
                child: pw.Text(
                  'Note',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.normal,
                  ),
                )),
            pw.SizedBox(height: 10),

            // Eighth Row: USD Rate at the Time of Transaction
            pw.Align(
              alignment: pw.Alignment.centerLeft, // 左对齐
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'BTC - USD RATE AT THE TIME OF TRANSACTION',
                    style: pw.TextStyle(
                      fontSize: 7,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.Text(
                    'OMNI LAYER BALANCES ARE NOT INCLUDED IN THIS REPORT',
                    style: pw.TextStyle(
                      fontSize: 7,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),

            // Seventh Row: Note Header
            pw.Align(
                alignment: pw.Alignment.centerLeft, // 左对齐
                child: pw.Text(
                  'DISCLAIMER',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.normal),
                )),
            pw.SizedBox(height: 10),
            // Eighth Row: USD Rate at the Time of Transaction
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'THIS RECEIPT HAS GENERATED AUTOMATICALLY ON #${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())} (UTC) AND IS BASED ON PUBLIC DATA FROM THEBITCOIN BLOCKCHAIN',
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    // 生成并保存为文件
    //生成的pdf名称替换为WALLET STATEMENT#1-1231（最后的4位数字是用户选择的日期，前面的文本“WALLET STATEMENT#1-”固定不变~）
    await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            "WALLET STATEMENT#1-${DateFormat('MMdd').format(DateTime.now())}.pdf");
  }

  // 获取当前日期
  DateTime endDate = DateTime.now();

  // 获取七天前的日期
  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF39D2C0),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 3.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.8,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    20.0, 44.0, 20.0, 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'pozov0xz' /* Account Statement */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Lexend',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              11.0, 0.0, 0.0, 0.0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  1.0, 0.0, 0.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                buttonSize: 48.0,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed('MY_Card');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 350.0,
                      height: 400.0,
                      child: custom_widgets.DateRangePicker(
                        width: 350.0,
                        height: 400.0,
                        buttonHintText: 'Select Date Range',
                        buttonTextColor: Colors.red,
                        initialStartDate: startDate,
                        initialEndDate: endDate,
                        onDateRangePicked:
                            (startDateSelected, endDateSelected) async {
                          startDate = startDateSelected ?? DateTime.now();
                          endDate = endDateSelected ?? DateTime.now();
                          safeSetState(() {});
                        },
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    StreamBuilder<List<BudgetListRecord>>(
                      stream: queryBudgetListRecord(
                        queryBuilder: (budgetListRecord) =>
                            budgetListRecord.where(
                          'budgetUser',
                          isEqualTo: currentUserReference,
                        ),
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: SpinKitPumpingHeart(
                                color: FlutterFlowTheme.of(context).primary,
                                size: 40.0,
                              ),
                            ),
                          );
                        }
                        List<BudgetListRecord> buttonBudgetListRecordList =
                            snapshot.data!;
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final buttonBudgetListRecord =
                            buttonBudgetListRecordList.isNotEmpty
                                ? buttonBudgetListRecordList.first
                                : null;

                        return FFButtonWidget(
                          onPressed: () async {
                            // _model.apiResulttaw =
                            // await GeneratePDFCall.call();
                            //
                            // if ((_model.apiResulttaw?.succeeded ?? true)) {
                            //   context.pushNamed('AccountStatement');
                            // }

                            // if (!DateSelectionPage.isDateRangeValid(
                            //     context, startDate, endDate)) {
                            //   return;
                            // }
                            try {
                              Future<List<BitcoinData>> futureBitcoinData =
                                  BitcoinApi.fetchBitcoinHistory(
                                      startDate, endDate);
                              futureBitcoinData.then((value) =>
                                  _generateAndDownloadPdf(value, context));
                            } catch (e) {
                              print(e);
                            }
                            // 解析 JSON 数据

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            '9l7pbjcj' /* Download ↓ */,
                          ),
                          options: FFButtonOptions(
                            width: 300.0,
                            height: 70.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: const Color(0xFF39D2C0),
                            textStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Lexend',
                                  color: const Color(0xFFF1F2F2),
                                  letterSpacing: 0.0,
                                  decoration: TextDecoration.underline,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
