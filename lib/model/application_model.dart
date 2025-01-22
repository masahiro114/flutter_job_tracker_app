class ApplicationModel {
  final String title;
  final String subtitle;
  final String description;
  final String status;
  final String? link; // Optional
  final String? coverLetter; // Optional
  final String? resume; // Optional

  // Constructor with named parameters, making link, coverLetter, and coverResume optional
  ApplicationModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.status,
    this.link,
    this.coverLetter,
    this.resume,
  });

  // Static method to return default values
  static ApplicationModel defaultData() {
    return ApplicationModel(
      title: 'Job Title',
      subtitle: 'Job Subtitle',
      description: 'Job Description',
      status: 'Not Applied',
      link: null, // Default to null if not provided
      coverLetter: null, // Default to null
      resume: null, // Default to null
    );
  }
}
