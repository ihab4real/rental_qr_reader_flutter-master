import 'package:flutter/material.dart';
import 'package:qr_reader/ScanQRCodePage.dart';
import 'package:qr_reader/constants.dart';
import 'package:qr_reader/components/DismissibleList.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ScanChoicesPage extends StatefulWidget {
  const ScanChoicesPage({Key? key}) : super(key: key);

  @override
  State<ScanChoicesPage> createState() => _ScanChoicesPageState();
}

class _ScanChoicesPageState extends State<ScanChoicesPage> {
  String _scanBarcode = 'Unknown';
  List<Map<String, dynamic>> lst = [
    {"choice": "Get your key", "icon": Icons.key},
    {"choice": "Return your key", "icon": Icons.car_rental},
  ];

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } catch (err) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan Choises",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: gDarkPrimaryColor,
      ),
      body: Container(
        child: DismissibleList(
            title: "Who are you",
            items: lst,
            itemBuilder: buildSpotItem,
            onItemClicked: onItemClicked_),
      ),
    );
  }

  Widget buildSpotItem(BuildContext context, int index, item) {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  item["icon"],
                  size: 48,
                  color: gSecondaryTextColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["choice"],
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 22,
                        color: gPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Future<void> onItemClicked_(int i, item) async {
    await scanQR();

    if (_scanBarcode == "-1") {
      return;
    }

    await Firebase.initializeApp();

    final db = FirebaseDatabase.instance;

    await db
        .ref("car" + _scanBarcode + "/")
        .set((item["choice"] == "Get your key" ? "get" : "return"));
  }
}
