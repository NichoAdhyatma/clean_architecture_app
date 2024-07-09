import 'package:blog_app_clean_tdd/core/utils/calculate_reading_time.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/entities/blog.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          BlogViewerPage.route(blog),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                        ),
                        child: Chip(
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            ListTile(
              title: Text(
                blog.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: EdgeInsets.zero,
              titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text("${calculateReadingTime(blog.content)} min")
          ],
        ),
      ),
    );
  }
}
