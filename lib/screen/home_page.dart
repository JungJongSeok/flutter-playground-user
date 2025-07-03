import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/home_viewmodel.dart';
import 'package:playground/service/user_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final HomeViewModel _homeViewModel =
      HomeViewModel(userService: UserServiceImpl());

  @override
  Widget build(BuildContext context) {
    final init = ref.watch(_homeViewModel.initProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: init.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) {
          final users = ref.watch(_homeViewModel.userDataProvider);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) {
              if (index == users.length - 1) {
                ref.watch(_homeViewModel.moreProvider);
              }
              return ListTile(title: Text(users[index].email ?? ""));
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
