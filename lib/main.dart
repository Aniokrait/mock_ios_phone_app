import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/new_contact_page.dart';
import 'package:mock_ios_phone_app/pages/pages.dart';

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
      //home: const MyHomePage(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'new-contact':
            return MaterialPageRoute(
              builder: (context) => const NewContactPage(),
              fullscreenDialog: true,
            );
        }
      },
      routes: {
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('aaa'),
      ),
      body: pages[ref.watch(tabIndex)],
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

//一旦初期値をキーパッドページに
final tabIndex = StateProvider<int>((ref) => 3);
