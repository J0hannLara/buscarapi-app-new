import 'package:flutter/material.dart';

class NFCStatusScanWidget extends StatelessWidget {
  final String message;
  final bool isLoading;

  const NFCStatusScanWidget({
    Key? key,
    required this.message,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.nfc, size: 100, color: theme.colorScheme.secondary),
        const SizedBox(height: 30),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        if (isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
