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
  final HomeViewModel _homeViewModel = HomeViewModel(userService: UserServiceImpl());

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(_homeViewModel.initProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: provider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) => ListTile(title: Text(items[i].email ?? "")),
        ),
      ),
    );
  }
}