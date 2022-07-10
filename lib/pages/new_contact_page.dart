import 'package:flutter/material.dart';

class NewContactPage extends StatelessWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'キャンセル',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        title: const Text('新規連絡先'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('aaa'),
      ),
    );
  }
}
