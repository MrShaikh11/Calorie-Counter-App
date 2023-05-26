class CalorieCounter {
  int? id;
  String? name;
  int? cal;
  String? qty;

  CalorieCounter({this.id, this.name, this.cal, this.qty});

  CalorieCounter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cal = json['cal'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cal'] = this.cal;
    data['qty'] = this.qty;
    return data;
  }
}
