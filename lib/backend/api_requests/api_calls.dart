import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GeneratePDFCall {
  static Future<ApiCallResponse> call({
    String? htmlContent =
        '\"<!DOCTYPE html> <html> <head>   <style>     body {       font-family: monospace;       max-width: 1000px;       margin: 20px auto;       padding: 20px;       line-height: 1.6;     }     .header {       display: flex;       justify-content: space-between;       align-items: center;       margin-bottom: 20px;     }     .logo {       display: flex;       align-items: center;       gap: 10px;     }     .logo-text {       color: #2ea44f;       font-weight: bold;       font-size: 24px;     }     .checkmark {       width: 30px;       height: 30px;       background-color: #2ea44f;       border-radius: 5px;       position: relative;     }     .checkmark::after {       content: \"✓\";       color: white;       position: absolute;       top: 50%;       left: 50%;       transform: translate(-50%, -50%);     }     .stamp {       border: 2px solid #8b0000;       padding: 10px;       color: #8b0000;       text-align: right;     }     .divider {       border-top: 1px dotted #000;       margin: 20px 0;     }     .wallet-info {       margin: 20px 0;     }     .balance-table {       width: 100%;       border-collapse: collapse;       margin: 20px 0;     }     .balance-table td {       padding: 8px 0;     }     .transactions-table {       width: 100%;       border-collapse: collapse;       margin: 20px 0;     }     .transactions-table th,     .transactions-table td {       padding: 8px;       text-align: left;       border-bottom: 1px solid #ddd;     }     .hash {       color: #0066cc;       word-break: break-all;     }     .notes {       margin-top: 40px;       font-size: 0.9em;     }   </style> </head> <body>   <div class=\"header\">     <div class=\"logo\">       <div class=\"checkmark\"></div>       <div class=\"logo-text\">BTCBOX</div>     </div>     <div class=\"stamp\">       BTC Box<br>       https://www.btc...jp/<br>       2023-09-01 - 2023-9-30     </div>   </div>    <div class=\"divider\"></div>    <h1>WALLET STATEMENT &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BITCOIN</h1>    <div class=\"divider\"></div>    <div class=\"wallet-info\">     <p>COMPANY NAME: Wetrade Bit Technology Limited</p>     <p>WALLET ADDRESS: <span style=\"color: #0066cc\">1Fb8G86EjJnWaFxR8564gnMXyFxAgFH7Jr</span></p>     <p>STATEMENT PERIOD: 2023-09-01 - 2023-09-30</p>   </div>    <h2>BTC BALANCE SUMMARY:</h2>    <table class=\"balance-table\">     <tr>       <td>STARTING BALANCE (2023-09-01)</td>       <td>500.20181774 BTC</td>       <td style=\"text-align: right\">12,973,734.55 USD</td>     </tr>     <tr>       <td>ENDING BALANCE (2023-09-30)</td>       <td>500.19478610 BTC</td>       <td style=\"text-align: right\">13,457,240.53 USD</td>     </tr>     <tr>       <td>TOTAL RECEIVED</td>       <td>44.99192768 BTC</td>       <td></td>     </tr>     <tr>       <td>TOTAL SENT</td>       <td>44.99895932 BTC</td>       <td></td>     </tr>   </table>    <h2>HISTORY OF TRANSACTIONS: 2023-09-01 - 2023-09-30</h2>    <table class=\"transactions-table\">     <tr>       <th>#</th>       <th>TIME</th>       <th></th>       <th>AMOUNT (BTC)</th>       <th>AMOUNT (USD)</th>       <th>TRANSACTION HASH</th>     </tr>     <tr>       <td>1</td>       <td>2023-09-03<br>02:39:19</td>       <td>Sent</td>       <td>0.00703164</td>       <td>181.82</td>       <td class=\"hash\">699388c69adce089e601eac996a9f67e7a97df4805388a8323f92058f435e538</td>     </tr>   </table>    <div class=\"notes\">     <h3>NOTE</h3>     <p>BTC-USD RATE AT THE TIME OF TRANSACTION .</p>     <p>OMNI LAYER BALANCES ARE NOT INCLUDED IN THIS REPORT .</p>      <h3>DISCLAIMER</h3>     <p>THIS RECEIPT WAS GENERATED AUTOMATICALLY ON 2023-09-25 08:51 (UTC) AND IS BASED ON PUBLIC DATA FROM THE BITCOIN BLOCKCHAIN .</p>   </div> </body> </html>\"',
    String? fileName = '',
  }) async {
    const ffApiRequestBody = '''
{
  "source": "{{htmlContent}}",
  "landscape": false
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GeneratePDF',
      apiUrl: 'https://api.pdfshift.io/v3/convert/pdf',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic YXBpOnNrXzQzYjUxMGE5MjJiNzgyMGEzMjJjNTI4ZWFjM2ZiYmNmMDU1NjVkZTE=',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetBitcoinHistoryCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetBitcoinHistory',
      apiUrl: 'https://api.coincap.io/v2/assets/bitcoin/history?interval=d1',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
