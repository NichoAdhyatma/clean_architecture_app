import 'package:blog_app_clean_tdd/core/helper/sizedbox_ext.dart';
import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';
import 'package:blog_app_clean_tdd/core/utils/card_color_selector.dart';
import 'package:blog_app_clean_tdd/core/utils/show_snackbar.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(
          BlogGetAll(),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddNewBlogPage.route(),
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];

                return BlogCard(
                  blog: blog,
                  color: cardColorSelector(index),
                );
              },
            );
          }

          return 0.heightSb;
        },
      ),
    );
  }
}
