import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactif widget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Interactif widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String changed;
  String submitted;

  List<Widget> textField() {
    List<Widget> l = [
      TextField(
        keyboardType: TextInputType.text,
        onChanged: (String data) {
          setState(() {
            changed = data;
          });
        },
        onSubmitted: (String data) {
          setState(() {
            submitted = data;
          });
        },
        decoration: InputDecoration(
            labelText: 'Entrer votre nom'
        ),
      ),
      Text(changed ?? ''),
      Text(submitted ?? ''),
    ];
    return l;
  }

  Map check = {
    'carottes' : false,
    'bananes' : false,
    'yaourt' : false,
    'pain' : false
  };

  List<Widget> checkList() {
    List<Widget> l = [];
    check.forEach((key, value) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              key,
            style: TextStyle(
              color: value ? Colors.red : Colors.grey
            ),
          ),
          Checkbox(
              value: value,
              onChanged: (bool b) {
                setState(() {
                  check[key] = b;
                });
              })
        ],
      );
      l.add(row);
    });
    return l;
  }

  int itemSelected;

  List<Widget> radios() {
    List<Widget> l = [];
    for(int i = 0; i<4; i++) {
      Row row = Row(
        children: [
          Text('Choix numéro ${i+1}'),
          Radio(
              value: i,
              groupValue: itemSelected,
              onChanged: (int x) {
                setState(() {
                  itemSelected = x;
                });
              })
        ],
      );
      l.add(row);
    }
    return l;
  }

  bool switchActive = false;

  List<Widget> switchs() {
    List<Widget> l = [
      Text('Your switch is $switchActive'),
      Switch(
          value: switchActive,
          activeColor: Colors.green,
          inactiveTrackColor: Colors.red,
          onChanged: (bool b) {
            setState(() {
              switchActive = b;
            });
          }),
    ];
    return l;
  }

  double sliderValue = 0.0;

  List<Widget> sliders() {
    List<Widget> l = [
      Text('Current value is $sliderValue'),
      Slider(
          value: sliderValue,
          min: 0.0,
          max: 10.0,
          activeColor: Colors.pinkAccent,
          inactiveColor: Colors.black,
          divisions: 5,
          onChanged: (double d) {
            setState(() {
              sliderValue = d;
            });
          })
    ];
    return l;
  }

  DateTime currentDate;
  TimeOfDay currentHour;

  List<Widget> datePicker() {
    List<Widget> l = [
      Text('Show Picker by pressing button'),
      Text(currentDate == null ? '' : '${currentDate.day}/${currentDate.month}/${currentDate.year}'),
      Text(currentHour == null ? '' : '${currentHour.hour}:${currentHour.minute}'),
      ElevatedButton(
          onPressed: showDate,
          child: Text('Date Me')),
      ElevatedButton(
          onPressed: showHour,
          child: Text('Hour Me'))
    ];
    return l;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: datePicker()
          //change for textField, or checkList, radios, switchs, sliders
          // datePicker
        )
      ),
    );
  }

  Future<Null> showDate() async {
    DateTime dateChoice = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime(1976),
        lastDate: DateTime(2040));
    if (dateChoice != null) {
      setState(() {
        currentDate = dateChoice;
      });
    }
  }

  Future<Null> showHour() async {
    TimeOfDay hourChoice = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    if (hourChoice != null) {
      setState(() {
        currentHour = hourChoice;
      });
    }
  }
}
