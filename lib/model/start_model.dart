class StartPageModel {
  final String title;
  final String subtitle;
  final String buttonText;

  StartPageModel({
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  // You could fetch this data from an API or a database, but for simplicity:
  static StartPageModel defaultData() {
    return StartPageModel(
      title: 'Job Tracker',
      subtitle: 'Your path to career success, tracked and managed.',
      buttonText: 'Continue to sign up',
    );
  }
}
