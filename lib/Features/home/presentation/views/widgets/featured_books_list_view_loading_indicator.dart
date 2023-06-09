import 'package:bookly/Features/home/presentation/views/widgets/custom_book_image_loading_indicator.dart';
import 'package:bookly/core/widgets/custom_feading_widget.dart';
import 'package:flutter/cupertino.dart';

class FeaturedBooksListViewLoadingIndicator extends StatelessWidget {
  const FeaturedBooksListViewLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Padding(
              padding:EdgeInsets.symmetric(horizontal: 8),
              child:CustomBookImageLoadingIndicator(),
            );
          },
        ),
      ),
    );
  }
}
