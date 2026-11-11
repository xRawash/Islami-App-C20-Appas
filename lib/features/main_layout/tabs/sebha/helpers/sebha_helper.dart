class SebhaHelper {
  static const List<String> praisesKeys = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];

  static Map<String, dynamic> tapSebha({
    required int currentPageIndex,
    required List<int> praisesCounts,
    required double currentTurns,
  }) {
    double turns = currentTurns + (1 / 33);
    List<int> counts = List.from(praisesCounts);
    counts[currentPageIndex]++;
    
    int pageIndex = currentPageIndex;
    bool shouldAnimatePage = false;

    if (counts[currentPageIndex] >= 33) {
      counts[currentPageIndex] = 0;
      pageIndex = (currentPageIndex + 1) % praisesKeys.length;
      shouldAnimatePage = true;
    }

    return {
      'turns': turns,
      'counts': counts,
      'pageIndex': pageIndex,
      'shouldAnimatePage': shouldAnimatePage,
    };
  }
}
