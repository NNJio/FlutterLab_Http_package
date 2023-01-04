import 'package:flutter/material.dart';
import 'package:test_package/components/moneybox.dart';
import 'package:test_package/controllers/get_exchange_rate.dart';
import 'package:test_package/models/exchange_rate.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExChangeRate _dataFormAPI;
  final newtStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.amber,
  );

  @override
  void initState() {
    super.initState();
    getExchangerate();
  }

  Future<ExChangeRate> getExchangerate() async {
    var url =
        Uri.https('cdn.moneyconvert.net', '/api/latest.json', {'q': '{http}'});
    var response = await http.get(url);
    _dataFormAPI = exChangeRateFromJson(response.body);
    return _dataFormAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Http',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getExchangerate(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MoneyBox('USD', result.rates['USD'], Colors.blue, 120),
                    const SizedBox(height: 10),
                    MoneyBox('THB', result.rates['THB'], Colors.green, 120),
                    const SizedBox(height: 10),
                    
                    
                    
                    

                    
                    
                  ],
                ),
              ),
            );
            //!---------------

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   color: Colors.amber[100],
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //!---------------
            //     ListView(
            //   children: [
            //     ListTile(title: Text('Status : ${result.table}')),
            //     ListTile(title: Text('${result.rates['THB'].toString()} ฿')),
            //     ListTile(title: Text('${result.lastupdate}')),
            //   ],
            // );
            //!---------------

            //     ],
            //   ),
            // );
            //!---------------

          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
