class HomeModel {
  HomeModel({
    required this.status,
    required this.data,
    required this.message,
  });

  String status;
  Data data;
  String message;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.images,
  });

  List<String> images;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
