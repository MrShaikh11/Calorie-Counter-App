class CalorieCounter {
  int? id;
  String? name;
  String? cal;

  CalorieCounter({this.id, this.name, this.cal});

  CalorieCounter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cal = json['cal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cal'] = this.cal;
    return data;
  }
}
