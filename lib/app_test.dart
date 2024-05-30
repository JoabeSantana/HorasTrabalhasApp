import 'package:flutter/material.dart';

class AppTest extends StatelessWidget {
  const AppTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AppTestWidget());
  }
}

class AppTestWidget extends StatefulWidget {
  const AppTestWidget({super.key});

  @override
  State<AppTestWidget> createState() => _AppTestWidgetState();
}

class _AppTestWidgetState extends State<AppTestWidget> {
  List<Widget> list = [];

  void addWidget() {
    print('ok');
    setState(() {
      list.add(const Text("Oh Yes Jobs"));
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      list.add(Text("Jobs"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Teste"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: list,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addWidget,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
