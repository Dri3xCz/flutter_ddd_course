enum LocalizationLanguage {
  English(languageCode: 'en'),
  Czech(languageCode: 'cs');

  final String languageCode;

  const LocalizationLanguage({
    required this.languageCode,
  });
}