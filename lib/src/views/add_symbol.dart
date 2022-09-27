import 'package:flutter/material.dart';

/// Displays a list of SampleItems.
class AddSymbolView extends StatelessWidget {
  const AddSymbolView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add symbol'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const Center(child: Text("Add symbol")));
  }
}
