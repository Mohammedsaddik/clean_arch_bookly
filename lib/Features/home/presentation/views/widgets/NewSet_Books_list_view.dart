import 'package:bookly/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:bookly/core/errors/Error_And_Loading_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'NewSet_Books_list_view_item.dart';

class BestSellerListView extends StatefulWidget {
  const BestSellerListView({
    super.key,
  });

  @override
  _BestSellerListViewState createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends State<BestSellerListView> {
  final ScrollController  _scrollController = ScrollController();
  var nextPage = 1;
  var isLoding =false;
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }



  void _onScroll() async{
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >=  0.7*maxScroll) {
      if(!isLoding){
        isLoding=true;
        await BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks(
          PageNumber: nextPage++,);
        isLoding=false;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          return ListView.builder(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BookListViewItem(
                  image: state.books[index].image ?? '',
                  title: state.books[index].title,
                  autherName: state.books[index].authorName ?? '',
                ),
              );
            },
          );
        } else if (state is NewestBooksFailure) {
          return const Center(
              child: CustomWidget(
                errorMessage: 'Error',
              ));
        } else {
          return const Center(
              child: CustomWidget(
                errorMessage: 'Loading',
              ));
        }
      },
    );
  }
}
