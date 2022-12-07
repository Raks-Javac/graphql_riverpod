import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_riverpod/data/client_config.dart';

final clientApiServiceProvider = Provider<ClientApiService>((ref) {
  final providerApiConfig = ref.watch(appClientConfigProvider);
  return ClientApiService(providerApiConfig);
});

class ClientApiService {
  ClientApiService(this.appClientConfig);

  AppClientConfig appClientConfig;
  Future<dynamic> queryData(String payload,
      {dynamic paramters, dynamic url}) async {
    // final QueryResult result = await appClientConfig.client.query(
    //   QueryOptions(document: gql(payload), variables: paramters ?? {}),
    // );

    // if (result.hasException) {
    //   print("hello");
    //   throw CustomException(result.exception.toString());
    // }
    // return result.data;

    const String query = r'''
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
      ''';

    final response = await appClientConfig.client.query(
      QueryOptions(
        document: gql(query),
        variables: const {
          'name': 'nobody',
        },
      ),
    );
    print(response.data);
    if (response.hasException) {
      print(response.exception.toString());
    }

    // final data = Data.fromJson(response.data);
    return response.data;
  }

  Future<dynamic> mutateData(dynamic payload,
      {dynamic paramters, dynamic url}) async {
    final QueryResult result = await appClientConfig.client.mutate(
        MutationOptions(document: gql(payload ?? ""), variables: paramters));

    if (result.hasException) {
      throw CustomException(result.exception.toString());
    }
    return result.data;
  }
}

class CustomException implements Exception {
  final dynamic message;

  CustomException([this.message]);
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class SocketException extends CustomException {}
