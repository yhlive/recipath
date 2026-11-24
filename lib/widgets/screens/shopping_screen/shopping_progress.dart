typedef ShoppingProgress = ({int checked, int total});

ShoppingProgress countShoppingProgress(Iterable<bool> flags) {
  var checked = 0;
  var total = 0;
  for (final isChecked in flags) {
    total++;
    if (isChecked) {
      checked++;
    }
  }
  return (checked: checked, total: total);
}
