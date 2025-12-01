import 'package:flutter/material.dart';
import '../widgets/nfc_options_list.dart';

class NFCOptionsPage extends StatelessWidget {
  const NFCOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones NFC y QR', style: textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: NFCOptionsList(),
      ),
    );
  }
}
