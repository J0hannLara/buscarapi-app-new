import 'package:flutter/material.dart';

class NfcStatusWidget extends StatelessWidget {
  final String statusMessage;
  final bool isWriting;

  const NfcStatusWidget({
    super.key,
    required this.statusMessage,
    required this.isWriting,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.nfc,
          size: 100,
          color: theme.colorScheme.secondary,
        ),
        const SizedBox(height: 30),
        Text(
          statusMessage,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        if (isWriting)
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
