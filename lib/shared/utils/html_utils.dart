/// Utility functions for handling HTML content
class HtmlUtils {
  /// Strips HTML tags and decodes common HTML entities from a string
  static String stripHtml(String htmlString) {
    // Remove HTML tags
    String text = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');

    // Decode common HTML entities
    text = text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&apos;', "'");

    // Replace multiple spaces with single space
    text = text.replaceAll(RegExp(r'\s+'), ' ');

    // Trim leading/trailing whitespace
    text = text.trim();

    return text;
  }
}
