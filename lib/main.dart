import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
      builder: (BuildContext context) => MyCustomState(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // jika menggunakan ini akan membuat fungsi build terpanggil terus menerus ketika perubahan state, jadi saya komen
    // final customState = Provider.of<MyCustomState>(context);
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Center(
        child: Consumer<MyCustomState>(
          builder: (BuildContext context, value, Widget child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${value._counter}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          value.increment();
                        },
                        icon: Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          value.decrement();
                        },
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  )
                ],
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => OtherPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyCustomState with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  set counter(int newValue) {
    _counter = _counter + newValue;
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customState = Provider.of<MyCustomState>(context);
    return Scaffold(
      body: Center(
        child: Text('${customState._counter}'),
      ),
    );
  }
}
