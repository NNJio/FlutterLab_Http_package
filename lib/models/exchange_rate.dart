import 'dart:convert';

ExChangeRate exChangeRateFromJson(String str) => ExChangeRate.fromJson(json.decode(str));

String exChangeRateToJson(ExChangeRate data) => json.encode(data.toJson());

class ExChangeRate {
    ExChangeRate({
        required this.table,
        required this.rates, 
        required this.lastupdate,
    });

    String table;
    Map<String, double> rates;
    DateTime lastupdate;

    factory ExChangeRate.fromJson(Map<String, dynamic> json) => ExChangeRate(
        table: json["table"],
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        lastupdate: DateTime.parse(json["lastupdate"]),
    );

    Map<String, dynamic> toJson() => {
        "table": table,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "lastupdate": lastupdate.toIso8601String(),
    };
}
