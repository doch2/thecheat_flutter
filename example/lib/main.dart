import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thecheat_flutter/thecheat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  TheCheatFlutterPlugin().initializeApp(
    "YOUR_API_KEY",
    "YOUR_ENCRYPT_KEY"
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TheCheat Plugin Example Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThecheatFraudSearch _fraudSearch = ThecheatFraudSearch();

  final searchKeyword = TextEditingController();
  String responseData = "(응답 결과 표시)";

  late double _height, _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _width * 0.5,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: searchKeyword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  labelText: "검색할 키워드",
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () async {
                responseData = (await _fraudSearch.search(searchKeyword.text, FraudSearchType.phone)).toJson().toString();
                setState(() {});
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text("사기 기록 조회하기 (휴대전화)", style: TextStyle(color: Colors.white))),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () async {
                responseData = (await _fraudSearch.search(searchKeyword.text, FraudSearchType.account)).toJson().toString();
                setState(() {});
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text("사기 기록 조회하기 (계좌번호)", style: TextStyle(color: Colors.white))),
              ),
            ),
            const SizedBox(height: 36),
            const Text("API 응답 결과", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            SizedBox(
              width: _width * 0.8,
              child: Text(responseData),
            )
          ],
        ),
      ),
    );
  }


  void _showToast(String content) => Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xE6FFFFFF),
      textColor: Colors.black,
      fontSize: 13.0
  );
}