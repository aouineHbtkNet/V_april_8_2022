import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simo_v_7_0_1/screens/webpage_mercadopago.dart';
import 'package:simo_v_7_0_1/widgets_utilities/pop_up_menu_users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key? key}) : super(key: key);
  static const String id = '/ChannelPage';

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  static final channelForPayementName = 'channelForPayement';
  final methodChannelPayement = MethodChannel(channelForPayementName);
   bool isLoading= false;
  String batteryPercentage = 'Battery Percentage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                //
                //  _showToast();
                // _payuPayCreditcard(
                //   // ApiKey: '4Vj8eK4rloUd272L48hsrarnUA',
                //   // ApiLogin: 'pRRXKOl8ikMmt9u',
                //   // accountId: '512321',
                //   ApiKey: 'P0XzeB3zO5Ri455pFa710NrJFM',
                //   ApiLogin: 'rEvkbOaXx1x3SBY',
                //   accountId: '512321',
                //   refrencecode: 'op',
                //   value: '65000',
                //   currency: 'COP',
                //   merchantId: '508029',
                // );

                setState(() {isLoading=true;});
                var mp =
                    MP('8953486731021726', '7clgGhXI07ZRrPeGOKusdMFeZ14Wp2zv');

                //  String? token = await mp.getAccessToken();
                //  print('Mercadopago token ${token}');
                var preference = {
                  "items": [
                    {
                      "title": "Total a pagar ",
                      "quantity": 1,
                      "currency_id": "COP",
                      "unit_price": 100000,
                    },

                  ]
                };
                var result = await mp.createPreference(preference);
                var preferenceId = result['response']['id'];
                var url = result['response']['init_point'];

                print('preference id   $preferenceId');

                print('preference  init id    $url');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebPageMercadoPago(
                      url: url,
                    ),
                  ),
                );

                setState(() {isLoading=false;});

                },







              child: isLoading==true? CircularProgressIndicator():Text('Pagar ahora')),

        ],
      ),
    );
  }

  //'com.hbtknet.e_tienda'
  Future<void> _showToast() async {
    //  'showToast' is  a key : the method name
    // final int showToast =
    await methodChannelPayement.invokeMethod('showToast', <String, String>{
      'msg': 'This is a toast message from Flutter to android'
    });
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<void> _payuPayCreditcard(
      {required String ApiKey,
      required String ApiLogin,
      required String merchantId,
      required String accountId,
      required String refrencecode,
      required String value,
      required String currency}) async {
    String input =
        '${ApiKey}~${merchantId}~${refrencecode}~${value}~${currency}';

    print('input string ===============$input');
    String signature = await generateMd5(input);
    print('signature ==========$signature');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sandbox.api.payulatam.com/payments-api/4.0/service.cgi'));
    request.body = json.encode({
      "language": "es",
      "command": "SUBMIT_TRANSACTION",
      "merchant": {"apiKey": ApiKey, "apiLogin": ApiLogin},
      "transaction": {
        "order": {
          "accountId": "512321",
          "referenceCode": refrencecode,
          "description": "Payment test description",
          "language": "es",
          "signature": signature,
          "notifyUrl": "http://www.payu.com/notify",
          "additionalValues": {
            "TX_VALUE": {"value": value, "currency": currency},
            "TX_TAX": {"value": 10378, "currency": "COP"},
            "TX_TAX_RETURN_BASE": {"value": 54622, "currency": "COP"}
          },
          "buyer": {
            "merchantBuyerId": "1",
            "fullName": "First name and second buyer name",
            "emailAddress": "buyer_test@test.com",
            "contactPhone": "7563126",
            "dniNumber": "123456789",
            "shippingAddress": {
              "street1": "Cr 23 No. 53-50",
              "street2": "5555487",
              "city": "Bogotá",
              "state": "Bogotá D.C.",
              "country": "CO",
              "postalCode": "000000",
              "phone": "7563126"
            }
          },
          "shippingAddress": {
            "street1": "Cr 23 No. 53-50",
            "street2": "5555487",
            "city": "Bogotá",
            "state": "Bogotá D.C.",
            "country": "CO",
            "postalCode": "0000000",
            "phone": "7563126"
          }
        },
        "payer": {
          "merchantPayerId": "1",
          "fullName": "First name and second payer name",
          "emailAddress": "payer_test@test.com",
          "contactPhone": "7563126",
          "dniNumber": "5415668464654",
          "billingAddress": {
            "street1": "Cr 23 No. 53-50",
            "street2": "125544",
            "city": "Bogotá",
            "state": "Bogotá D.C.",
            "country": "CO",
            "postalCode": "000000",
            "phone": "7563126"
          }
        },
        "creditCard": {
          "number": "4037997623271984",
          "securityCode": "321",
          "expirationDate": "2030/12",
          "name": "APPROVED"
        },
        "extraParameters": {"INSTALLMENTS_NUMBER": 1},
        "type": "AUTHORIZATION_AND_CAPTURE",
        "paymentMethod": "VISA",
        "paymentCountry": "CO",
        "deviceSessionId": "vghs6tvkcle931686k1900o6e1",
        "ipAddress": "127.0.0.1",
        "cookie": "pt1t38347bs6jc9ruv2ecpv7o2",
        "userAgent":
            "Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0",
        "threeDomainSecure": {
          "embedded": false,
          "eci": "01",
          "cavv": "AOvG5rV058/iAAWhssPUAAADFA==",
          "xid": "Nmp3VFdWMlEwZ05pWGN3SGo4TDA=",
          "directoryServerTransactionId": "00000-70000b-5cc9-0000-000000000cb"
        }
      },
      "test": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
