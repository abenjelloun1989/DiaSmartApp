import 'dart:convert';
import 'dart:developer';

class MealItem {
  final int id;
  final String meal;
  final DateTime mealTime;
  final double carbo;
  final double insulin;
  final double gluLevel;
  final double ratio;

  MealItem(
      {this.id,
      this.meal,
      this.mealTime,
      this.carbo,
      this.insulin,
      this.gluLevel,
      this.ratio});

  factory MealItem.fromJson(Map<String, dynamic> json) {
    log(jsonEncode(json));
    return MealItem(
        id: json['id'],
        meal: json['meal'],
        mealTime: json['mealTime'],
        carbo: json['carbo'],
        insulin: json['insulin'],
        gluLevel: json['gluLevel'],
        ratio: json['ratio']);
  }
}
