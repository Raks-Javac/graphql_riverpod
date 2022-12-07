import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_riverpod/data/client_config.dart';
import 'package:graphql_riverpod/views/app_main.dart';

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appClientConfigProvider);
    return GraphQLProvider(
      // client: ref.watch(appClientConfigProvider).client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GraphQL X Riverpod',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ShowAppResultView(),
      ),
    );
  }
}
