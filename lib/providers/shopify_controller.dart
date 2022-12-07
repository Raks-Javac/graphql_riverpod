import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_riverpod/repo/client_repo.dart';

final shofifyControllerProvider = StateNotifierProvider((ref) {
  final shopifyRepo = ref.watch(shopifyProvider);
  return ShopifyController(shopifyRepo);
});
final futureProviderMusic = FutureProvider((ref) {
  final stateController = ref.watch(shopifyProvider);
  return stateController.getShopifyMusic();
});

class ShopifyController extends StateNotifier<List<dynamic>> {
  ShopifyRepo shopifyRepo;
  ShopifyController(this.shopifyRepo) : super([]);
  Future getShopifyData() async {
    final getData = await shopifyRepo.getShopifyMusic();
    return getData;
  }
}
