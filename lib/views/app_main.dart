import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_riverpod/providers/shopify_controller.dart';

class ShowAppResultView extends ConsumerWidget {
  const ShowAppResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(futureProviderMusic);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ref.watch(futureProviderMusic).when(data: (data) {
                return Text(data.toString());
              }, error: (error, stackTrace) {
                print(error.toString());
                return const CircularProgressIndicator();
              }, loading: () {
                return const CircularProgressIndicator();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
