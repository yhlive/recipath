import 'package:drift/drift.dart' show Value;
import 'package:recipath/drift/database.dart';

Future<void> seedShoppingWorkshop(
  AppDatabase db, {
  required bool stress,
  bool allChecked = false,
}) async {
  const groceries = ['Tomatoes', 'Rice', 'Lemons', 'Olive oil'];
  const quick = ['Paper towels', 'Sparkling water'];
  final groceryCount = stress ? 240 : groceries.length;
  final quickCount = stress ? 60 : quick.length;

  await db.batch((batch) {
    batch.insertAll(db.tagTable, [
      TagTableCompanion.insert(
        id: 'produce',
        name: 'Produce',
        description: '',
        color: 0xff2e7d32,
        tagType: const Value('Grocery'),
      ),
      TagTableCompanion.insert(
        id: 'weekend',
        name: 'Weekend',
        description: '',
        color: 0xff1565c0,
        tagType: const Value('Grocery'),
      ),
    ]);
    batch.insertAll(db.groceryTable, [
      for (var i = 0; i < groceryCount; i++)
        GroceryTableCompanion.insert(
          id: 'grocery-$i',
          name: stress
              ? '${groceries[i % groceries.length]} ${i.toString().padLeft(3, '0')}'
              : groceries[i],
          normalAmount: 1,
          unit: 'Piece',
          conversionAmount: 1,
          conversionUnit: 'Piece',
        ),
    ]);
    batch.insertAll(db.groceryTagTable, [
      for (var i = 0; i < groceryCount; i++) ...[
        GroceryTagTableCompanion.insert(
          groceryId: 'grocery-$i',
          tagId: i.isEven ? 'produce' : 'weekend',
        ),
        if (i == 0 || (stress && i % 10 == 1))
          GroceryTagTableCompanion.insert(
            groceryId: 'grocery-$i',
            tagId: i.isEven ? 'weekend' : 'produce',
          ),
      ],
    ]);
    batch.insertAll(db.ingredientTable, [
      for (var i = 0; i < groceryCount; i++)
        IngredientTableCompanion.insert(
          id: 'ingredient-$i',
          amount: 1,
          unit: 'Piece',
          groceryId: 'grocery-$i',
        ),
    ]);
    batch.insertAll(db.shoppingTable, [
      for (var i = 0; i < groceryCount; i++)
        ShoppingTableCompanion.insert(
          id: 'shopping-$i',
          done: allChecked || (stress && i % 5 == 0),
          count: 1,
          ingredientId: 'ingredient-$i',
        ),
    ]);
    batch.insertAll(db.quickShoppingTable, [
      for (var i = 0; i < quickCount; i++)
        QuickShoppingTableCompanion.insert(
          id: 'quick-$i',
          done: allChecked || (stress ? i % 5 == 0 : i == 0),
          description: stress ? '${quick[i % quick.length]} $i' : quick[i],
        ),
    ]);
  });
}
