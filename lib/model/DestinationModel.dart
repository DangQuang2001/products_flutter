import 'dart:core';

class DestinationModel {
  final String id;
  final String name;
  final String image;
  final List<String> genre;
  final int rating;

  DestinationModel(this.id, this.name, this.image, this.genre, this.rating);

  static List<DestinationModel> MockData() {
    List<DestinationModel> ls = [];
    ls.add(DestinationModel(
        "1", "Lang Khai Dinh", "assets/images/_DSC2488.JPG", [''], 5));
    ls.add(DestinationModel(
        "2", "Lang Minh Mang", "assets/images/_DSC2531.JPG", [''], 5));
    ls.add(DestinationModel(
        "3", "Duong Ngo Quyen", "assets/images/_DSC2532.JPG", [''], 5));

    return ls;
  }
}
