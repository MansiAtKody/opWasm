///Model for static FAQ Data
class FaqModel {
  bool isExpanded;
  String title;
  String description;

  FaqModel({
    this.isExpanded = false,
    required this.title,
    required this.description,
  });
}
