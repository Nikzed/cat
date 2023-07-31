import 'package:cats/presentation/cats/bloc/cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatefulWidget {
  final PageController? pageController;

  const FeedPage({super.key, this.pageController});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    CatsBloc bloc = BlocProvider.of<CatsBloc>(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                BlocBuilder<CatsBloc, CatsState>(
                  builder: (context, state) {
                    if (state is CatsLoadingState) {
                      return const CustomNetworkImage(isLoading: true);
                    }
                    return const CustomNetworkImage(isLoading: false);
                  },
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is CatsErrorState) {
                        return Column(
                          children: [
                            const Text('Some error happened, try to reload the page: '),
                            ElevatedButton(
                              onPressed: () {
                                bloc.add(CatsLoadFactEvent());
                              },
                              child: const Text('Reload'),
                            ),
                          ],
                        );
                      } else if (state is CatsLoadingState) {
                        return const LinearProgressIndicator();
                      } else if (state is CatsLoadedState) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.factEntity.text,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                DateFormat.yMMMMd(
                                  Intl.systemLocale,
                                ).format(state.factEntity.time),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => bloc.add(CatsLoadFactEvent()),
                  child: const Text('‘Another fact!’'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => widget.pageController?.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                  child: const Text('‘Saved facts!’'),
                ),
              ],
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  static const String url = 'https://cataas.com/cat';

  final bool isLoading;

  const CustomNetworkImage({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      replacement: const SizedBox(
        height: 250,
        width: 250,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Image.network(
            '$url?time=${DateTime.now()}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
