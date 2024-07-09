import 'package:blog_app_clean_tdd/core/helper/sizedbox_ext.dart';
import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';
import 'package:blog_app_clean_tdd/core/utils/calculate_reading_time.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );

  final Blog blog;

  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                15.heightSb,
                Text(
                  "By ${blog.posterName}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "${DateFormat("d MMM yyyy").format(blog.updatedAt)} . "
                  "${calculateReadingTime(blog.content)} min read",
                  style: const TextStyle(
                    color: AppPallete.greyColor,
                  ),
                ),
                15.heightSb,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                20.heightSb,
                Text(
                  blog.content,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        height: 2,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
