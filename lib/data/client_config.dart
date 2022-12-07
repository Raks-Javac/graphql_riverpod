import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final appClientConfigProvider = Provider<AppClientConfig>((ref) {
  return AppClientConfig();
});

class AppClientConfig {
  static const String baseUrl = 'https://api.github.com/graphql';

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
        cache: GraphQLCache(store: HiveStore()),
      );
}
