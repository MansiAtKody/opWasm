/// Model for the static UI
class FaqModel {
  bool isExpandable = false;
  String title;
  String description;

  FaqModel(
      {this.isExpandable = false,
        required this.title,
        required this.description});
}