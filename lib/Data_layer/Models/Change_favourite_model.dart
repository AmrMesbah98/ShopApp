class ChangeFavouriteID {
  bool? status;
  String? message;

  ChangeFavouriteID({this.status, this.message});

  ChangeFavouriteID.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
