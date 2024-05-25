import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horas Trabalhadas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculador Horas Trabalhadas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> rows = [];

  void addRow() {
    setState(() {
      rows.add(getRow());
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 2; i++) {
      rows.add(getRow());
    }
  }

  Row getRow() {
    List<AcaoWidget> acoes = [];

    acoes.add(const AcaoWidget(acao: "Entrada"));
    acoes.add(const AcaoWidget(acao: "Saída"));

    Row row = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: acoes);

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: rows,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: OutlinedButton(
                          onPressed: addRow,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text("Adicionar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(400, 50),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text("Calcular"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcaoWidget extends StatelessWidget {
  const AcaoWidget({super.key, required this.acao});

  final String acao;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Text(acao),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 22,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    decoration: InputDecoration(
                        border: InputBorder.none, counterText: ""),
                  ),
                ),
                Text(":"),
                SizedBox(
                  width: 22,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    decoration: InputDecoration(
                        border: InputBorder.none, counterText: ""),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
