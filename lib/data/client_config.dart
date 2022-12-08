import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

final appClientConfigProvider =
    Provider.family<AppClientConfig, HiveStore>((ref, hiveStore) {
  return AppClientConfig(hiveStore);
});

class AppClientConfig {
  final HiveStore store;
  AppClientConfig(this.store);
  static const String baseUrl = 'https://countries.trevorblades.com/graphql';

  HttpLink get httpLink => HttpLink(baseUrl);
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  Link get link => authLink.concat(httpLink);
  GraphQLClient get client => GraphQLClient(
        link: httpLink,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: store),
        // cache: GraphQLCache(store: HiveStore()),
      );
}
