import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:graphql_riverpod/views/app_main.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AppConstants {
  static HiveStore? hiveConst;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  // await initHiveForFlutter();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  final store = await HiveStore.open(path: appDocumentDir.path);

  runApp(ProviderScope(
      child: MyApp(
    store: store,
  )));
}

class MyApp extends StatefulWidget {
  final dynamic store;
  const MyApp({super.key, this.store});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setState(() {
      AppConstants.hiveConst = widget.store;
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GraphQL X Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowAppResultView(),
    );
  }
}
