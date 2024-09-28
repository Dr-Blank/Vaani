extension TitleCase on Enum {
  String get properName {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  String get titleCase {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();
  }

  String get pascalCase {
    // capitalize the first letter of each word
    return name
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(0)}',
        )
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
