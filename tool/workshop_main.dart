// This isolated workshop deliberately substitutes the database and local services.
// ignore_for_file: riverpod_lint/scoped_providers_should_specify_dependencies

import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:recipath/drift/database.dart';
import 'package:recipath/drift/database_notifier.dart';
import 'package:recipath/l10n/app_localizations.dart';
import 'package:recipath/providers/application_path_provider.dart';
import 'package:recipath/root_routes.dart';
import 'package:recipath/widgets/filtering/filter_type_enum.dart';
import 'package:recipath/widgets/filtering/quick_filter_enum.dart';
import 'package:recipath/widgets/providers/backend/backend_config_notifier.dart';
import 'package:recipath/widgets/screens/recipe_screen/providers/quick_filter_notifier.dart';

import 'workshop_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const stress = String.fromEnvironment('SHOPPING_DATASET') == 'stress';
  final world = await createShoppingWorkshop(stress: stress);
  // The prepared workshop widget already owns the root ProviderScope.
  // ignore: riverpod_lint/missing_provider_scope
  runApp(world.app);
}

Future<({Widget app, AppDatabase db, GoRouter router, Directory directory})>
createShoppingWorkshop({required bool stress, bool allChecked = false}) async {
  final directory = await _workshopDirectory;
  PathProviderPlatform.instance = _WorkshopPaths(directory.path);
  localStorage.setItem(
    '${QuickFilterNotifier.quickFilterDataKey}_${FilterTypeEnum.shopping.name}',
    jsonEncode({QuickFilters.toEncoded(QuickFilters.cluster): true}),
  );

  final db = AppDatabase(NativeDatabase.memory());
  await seedShoppingWorkshop(db, stress: stress, allChecked: allChecked);
  final router = GoRouter(
    initialLocation: RootRoutes.shoppingRoute.path,
    routes: [
      RootRoutes.recipeRoute,
      RootRoutes.shoppingRoute,
      RootRoutes.storageRoute,
      RootRoutes.groceriesRoute,
      RootRoutes.tagRoute,
      RootRoutes.dashboardRoute,
      RootRoutes.recipeHistoryRoute,
      RootRoutes.recipeShoppingRoute,
      RootRoutes.settingsRoute,
      RootRoutes.importRoute,
    ],
  );

  return (
    db: db,
    router: router,
    directory: directory,
    app: ProviderScope(
      overrides: [
        databaseProvider.overrideWith((ref) => db),
        applicationPathProvider.overrideWith((ref) => directory),
        backendConfigProvider.overrideWithBuild((ref, notifier) => null),
      ],
      child: MaterialApp.router(
        title: 'ReciPath Shopping Workshop',
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
}

final _workshopDirectory = _createWorkshopDirectory();

Future<Directory> _createWorkshopDirectory() async {
  final directory = await Directory.systemTemp.createTemp('recipath-workshop-');
  const storage = 'storage-61f76cb0-842b-4318-a644-e245f50a0b5a.json';
  await File('${directory.path}/$storage').writeAsString('{}');
  PathProviderPlatform.instance = _WorkshopPaths(directory.path);
  await initLocalStorage();
  return directory;
}

class _WorkshopPaths extends PathProviderPlatform {
  _WorkshopPaths(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getTemporaryPath() async => path;
}
