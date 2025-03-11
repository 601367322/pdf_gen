import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'coin_cap_model.dart';
export 'coin_cap_model.dart';

class CoinCapWidget extends StatefulWidget {
  const CoinCapWidget({super.key});

  @override
  State<CoinCapWidget> createState() => _CoinCapWidgetState();
}

class _CoinCapWidgetState extends State<CoinCapWidget> {
  late CoinCapModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CoinCapModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Text(
          FFLocalizations.of(context).getText(
            '2y5ahe19' /* CoinCap */,
          ),
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 22.0,
                letterSpacing: 0.0,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: const SafeArea(
        top: true,
        child: FlutterFlowWebView(
          content: 'https://coincap.io/',
          bypass: false,
          height: 777.0,
          verticalScroll: false,
          horizontalScroll: false,
        ),
      ),
    );
  }
}
