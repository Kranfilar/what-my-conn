import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static void showTopSnackBar(
    BuildContext context,
    String title,
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        Text(title),
        subtitle: Text(message),
        background: color,
      );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => OverlaySupport(
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Teste de Conexão'),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Teste sua conexão\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            ElevatedButton(
              child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Icon(
                    Icons.wifi_tethering_sharp,
                    size: 96,
                  )),
              onPressed: () async {
                final result = await Connectivity().checkConnectivity();
                showConnectivitySnackBar(result, context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                onPrimary: Colors.white54, // <-- Splash color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showConnectivitySnackBar(ConnectivityResult result, BuildContext context) {
  var tlt = "";
  var msg = "";
  var clr = Colors.transparent;
  if (result == ConnectivityResult.none) {
    tlt = "Desconectado";
    msg = "Você não está conectado";
    clr = Colors.red.shade700;
  } else if (result == ConnectivityResult.mobile) {
    tlt = "Conectado";
    msg = "Você está conectado com o seu plano de dados";
    clr = Colors.amber.shade600;
  } else if (result == ConnectivityResult.wifi) {
    tlt = "Conectado";
    msg = "Você está conectado por uma rede WI-FI";
    clr = Colors.green;
  }
  Utils.showTopSnackBar(context, tlt, msg, clr);
}
