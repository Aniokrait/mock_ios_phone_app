import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/dial_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('aaa'),
      ),
      body: DialPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: ref.watch(tabIndex),
        onTap: (index) => {ref.read(tabIndex.notifier).state = index},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'よく使う項目'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '履歴'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '連絡先'),
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: 'キーパッド'),
          BottomNavigationBarItem(icon: Icon(Icons.voicemail), label: '留守番電話'),
        ],
      ),
    );
  }
}

final tabIndex = StateProvider<int>((ref) => 0);
