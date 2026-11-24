// Keep indexing, per-query preparation, and matching separate so callers reuse
// the same search rules in the list and in the workshop workload.
String indexSearchText(String text) => text;

String prepareSearchQuery(String text) => text;

bool matchesSearchText(String indexedText, String query) =>
    indexedText.toLowerCase().contains(query.toLowerCase());
