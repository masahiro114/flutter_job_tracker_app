// comparison_model.dart
class ComparisonPageModel {
  final String title;
  final String subtitle;
  final String buttonText;

  ComparisonPageModel({
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  // Static method to return default values for simplicity
  static ComparisonPageModel defaultData() {
    return ComparisonPageModel(
      title: 'Comparison',
      subtitle: 'You can compare similar application status among people.',
      buttonText: 'Next',
    );
  }
}
