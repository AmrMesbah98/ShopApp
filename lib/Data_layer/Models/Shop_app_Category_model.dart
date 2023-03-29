class CategoriesModel {
  bool? status;
  CategoriDataModel? data;

  CategoriesModel({this.status, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data =
        json['data'] != null ? CategoriDataModel.fromJson(json['data']) : null;
  }
}

class CategoriDataModel {
  int? currentPage;
  List<DataModel>? data;

  CategoriDataModel({
    this.currentPage,
    this.data,
  });

  CategoriDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel({this.id, this.name, this.image});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
