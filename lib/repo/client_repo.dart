import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_riverpod/data/client_service.dart';

final shopifyProvider = Provider<ShopifyRepo>((ref) {
  final clientApiProvider = ref.watch(clientApiServiceProvider);
  return MockShopifyRepo(clientApiProvider);
});

abstract class ShopifyRepo {
  Future<dynamic> getShopifyMusic();
}

class MockShopifyRepo implements ShopifyRepo {
  MockShopifyRepo(this.clientApiService);

  ClientApiService clientApiService;

  @override
  Future getShopifyMusic() async {
    final response = await clientApiService.queryData(r'''
      query getArtists($name: String!) {
          queryArtists(byName: $name) {
              name
              id
              image
              albums {
                id
                name
              }
          }
      }
    ''', paramters: {
      'name': 'asake',
    });
    print(response.toString());
    return null;
  }
}
