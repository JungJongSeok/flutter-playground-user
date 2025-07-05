import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extensions/collection.dart';
import '../service/user_service.dart';
import '../utils/custom_widget.dart';
import 'home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final HomeViewModel _homeViewModel =
      HomeViewModel(userService: UserServiceImpl());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset ||
          _scrollController.position.maxScrollExtent == 0.0) {
        ref.watch(_homeViewModel.moreProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Pair<Object, StackTrace?>>(_homeViewModel.networkErrorProvider,
        (previous, next) {
      CustomWidget.showToast(AppLocalizations.of(context)!.error_message_retry);
    });

    final init = ref.watch(_homeViewModel.initProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: init.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) {
          final users = ref.watch(_homeViewModel.userDataProvider);
          return ListView.builder(
            controller: _scrollController,
            itemCount: users.length,
            itemBuilder: (_, index) {
              return ListTile(title: Text(users[index].email ?? ""));
            },
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
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
