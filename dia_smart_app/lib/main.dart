import 'dart:async';
import 'dart:convert';

import 'package:diasmartapp/MealItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
Future<List<MealItem>> _getMeals() async {
  final response =
      await http.Client().get('http://10.0.2.2:5000/api/MealItems');

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => MealItem.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load meal item');
  }
}*/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dia Smart',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          buttonColor: Colors.purple,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary)),
      home: MyHomePage(title: 'Meals'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const baseUrl = "http://10.0.2.2:5000/api";

class API {
  static Future getMeals() {
    var url = baseUrl + "/MealItems";
    return http.get(url);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var _meals = new List<MealItem>();

  _getMeals() {
    API.getMeals().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _meals = list.map((model) => MealItem.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _meals.length,
            itemExtent: 60.0,
            itemBuilder: (context, index) {
              return ListTile(title: Text(_meals[index].id.toString()));
            } //_listItemBuilder,
            ),
      ),
    );
  }

  Widget _dialogBuilder(BuildContext context, MealItem mealItem) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Image(
          image: AssetImage('assets/images/' + mealItem.meal + '.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                mealItem.meal,
                style: localTheme.textTheme.headline4,
              ),
              Text(
                mealItem.mealTime.toIso8601String(),
                style: localTheme.textTheme.subtitle1
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Carbo : ' + mealItem.carbo.toString() + 'g',
                style: localTheme.textTheme.bodyText1,
              ),
              Text(
                'Insulin : ' + mealItem.insulin.toString() + 'u',
                style: localTheme.textTheme.bodyText1,
              ),
              Text(
                'GluLevel : ' + mealItem.gluLevel.toString() + 'mg/dL',
                style: localTheme.textTheme.bodyText1,
              ),
              SizedBox(
                height: 16.0,
              ),
              Wrap(
                alignment: WrapAlignment.end,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close')),
                  RaisedButton(
                    onPressed: () {},
                    child: const Text('Good'),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => _dialogBuilder(context, _meals[index])),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(_meals[index].meal,
            style: Theme.of(context).textTheme.headline5),
      ),
    );
  }

  /*final List<MealItem> _meals = <MealItem>[
    MealItem(
        id: 1,
        meal: 'breakfast',
        mealTime: DateTime.now(),
        carbo: 10,
        insulin: 1,
        gluLevel: 100,
        ratio: 0.1),
    MealItem(
        id: 2,
        meal: 'lunch',
        mealTime: DateTime.now(),
        carbo: 20,
        insulin: 2,
        gluLevel: 200,
        ratio: 0.2),
    MealItem(
        id: 3,
        meal: 'dinner',
        mealTime: DateTime.now(),
        carbo: 30,
        insulin: 3,
        gluLevel: 300,
        ratio: 0.3),
    MealItem(
        id: 4,
        meal: 'other',
        mealTime: DateTime.now(),
        carbo: 40,
        insulin: 4,
        gluLevel: 400,
        ratio: 0.4),
  ];*/
}
