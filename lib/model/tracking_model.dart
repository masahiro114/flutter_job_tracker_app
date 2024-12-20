class TrackingPageModel {
  final String title;
  final String subtitle;
  final String buttonText;

  TrackingPageModel({
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  // Static method to return default values
  static TrackingPageModel defaultData() {
    return TrackingPageModel(
      title: 'Tracking',
      subtitle: 'You can track job applications and check your status.',
      buttonText: 'Next',
    );
  }
}
