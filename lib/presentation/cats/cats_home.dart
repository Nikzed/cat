import 'package:cats/presentation/cats/bloc/cats_bloc.dart';
import 'package:cats/presentation/widgets/feed_page.dart';
import 'package:cats/presentation/widgets/history_page.dart';
import 'package:cats/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsHome extends StatelessWidget {
  const CatsHome({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(keepPage: true);

    return BlocProvider<CatsBloc>(
      create: (context) => injector<CatsBloc>()..add(CatsLoadFactEvent()),
      child: Scaffold(
        body: PageView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          children: [
            FeedPage(pageController: controller),
            const HistoryPage(),
          ],
        ),
      ),
    );
  }
}
