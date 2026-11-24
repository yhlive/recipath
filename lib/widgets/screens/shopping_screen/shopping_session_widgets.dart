import 'package:material_ui/material_ui.dart';
import 'package:recipath/l10n/app_localizations.dart';
import 'package:recipath/widgets/screens/shopping_screen/shopping_progress.dart';

class ShoppingProgressBar extends StatelessWidget {
  const ShoppingProgressBar({required this.progress, super.key});

  final ShoppingProgress progress;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final label = strings.shoppingSessionProgress(
      progress.checked,
      progress.total,
      progress.total - progress.checked,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            key: const ValueKey('shopping-progress-label'),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress.total == 0 ? 0 : progress.checked / progress.total,
            semanticsLabel: label,
          ),
        ],
      ),
    );
  }
}

class ShoppingSessionEmpty extends StatelessWidget {
  const ShoppingSessionEmpty({
    required this.allChecked,
    required this.onShowAll,
    this.quickAdd,
    super.key,
  });

  final bool allChecked;
  final VoidCallback? onShowAll;
  final Widget? quickAdd;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                allChecked
                    ? strings.shoppingSessionAllChecked
                    : strings.shoppingSessionNoMatch,
                textAlign: TextAlign.center,
              ),
              if (onShowAll != null)
                TextButton(
                  onPressed: onShowAll,
                  child: Text(strings.shoppingSessionShowAll),
                ),
              ?quickAdd,
            ],
          ),
        ),
      ),
    );
  }
}
