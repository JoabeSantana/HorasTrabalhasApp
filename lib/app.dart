import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
      home: const MyHomePage(title: 'Calculadora Horas Trabalhadas'),
      debugShowCheckedModeBanner: false,
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

  List<TextEditingController> controllers = [];

  String horasTrabalhadas = "00:00";

  bool isCampoValido(String valor) {
    return valor.isNotEmpty && !valor.contains('--');
  }

  void calcularHoras() {
    List<DateTime> horas = [];
    List<Duration> diferencasHoras = [];
    DateTime total = DateFormat("HH:mm").parse("00:00");

    for (var i = 0; i < controllers.length; i++) {
      if (i % 2 == 0 &&
          isCampoValido(controllers[i].text) &&
          isCampoValido(controllers[i + 1].text)) {
        DateTime time = DateFormat("HH:mm")
            .parse("${controllers[i].text}:${controllers[i + 1].text}");
        horas.add(time);
      }
    }

    for (var i = horas.length - 1; i >= 0; i--) {
      if (i % 2 == 0 && (i + 1) < horas.length) {
        Duration diferenca = horas[i + 1].difference(horas[i]);
        diferencasHoras.add(diferenca);
      }
    }

    for (var dif in diferencasHoras) {
      total = total.add(dif);
    }

    setState(() {
      horasTrabalhadas = DateFormat("HH:mm").format(total);
    });
  }

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

    controllers.add(TextEditingController(text: "--"));
    controllers.add(TextEditingController(text: "--"));
    controllers.add(TextEditingController(text: "--"));
    controllers.add(TextEditingController(text: "--"));

    acoes.add(AcaoWidget(
        acao: "Entrada",
        controllerHoras: controllers[controllers.length - 4],
        controllerMinutos: controllers[controllers.length - 3]));

    acoes.add(AcaoWidget(
        acao: "Saída",
        controllerHoras: controllers[controllers.length - 2],
        controllerMinutos: controllers[controllers.length - 1]));

    Row row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: acoes,
    );

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
              Column(
                children: [
                  const Text("Horas Trabalhadas"),
                  Text(horasTrabalhadas),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: OutlinedButton(
                  onPressed: calcularHoras,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 50),
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text("Calcular"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcaoWidget extends StatelessWidget {
  const AcaoWidget(
      {super.key,
      required this.acao,
      required this.controllerHoras,
      required this.controllerMinutos});

  final String acao;
  final TextEditingController controllerHoras;
  final TextEditingController controllerMinutos;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 22,
                  child: TextFieldHorasMinutos(controller: controllerHoras),
                ),
                const Text(":"),
                SizedBox(
                  width: 22,
                  child: TextFieldHorasMinutos(controller: controllerMinutos),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldHorasMinutos extends StatelessWidget {
  const TextFieldHorasMinutos({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLength: 2,
      decoration:
          const InputDecoration(border: InputBorder.none, counterText: ""),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
