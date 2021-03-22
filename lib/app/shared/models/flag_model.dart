class FlagModel {
  int id;
  String name;
  String img;

  FlagModel({this.id, this.name, this.img});

  FlagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}
