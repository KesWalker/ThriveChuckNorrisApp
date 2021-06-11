import 'package:flutter/material.dart';
import 'package:thrive_chuck_norris_kw/model/joke.dart';
import 'package:thrive_chuck_norris_kw/repo/chuckRepo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NeverEndingJokesList extends StatefulWidget {
  final ChuckRepo repo;

  const NeverEndingJokesList({
    required this.repo
  });

  @override
  State<StatefulWidget> createState() {
    return _NeverEndingJokesState();
  }
}

class _NeverEndingJokesState extends State<NeverEndingJokesList> {

  final _pagingController = PagingController<int, Joke>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newJokes = await widget.repo.getJokes(pageKey);
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(newJokes, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Never-ending jokes"),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh(),),
          child: PagedListView.separated(
            pagingController: _pagingController,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            builderDelegate: PagedChildBuilderDelegate<Joke>(
              itemBuilder: (context, joke, index) => Text(joke.joke),
              firstPageErrorIndicatorBuilder: (context) => Text("Error, please try again."),
              noItemsFoundIndicatorBuilder: (context) => Text("No jokes found :("),
            ),
          ),
        )
    );
  }

}