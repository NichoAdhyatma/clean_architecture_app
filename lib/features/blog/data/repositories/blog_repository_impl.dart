import 'dart:io';

import 'package:blog_app_clean_tdd/core/constants/constants.dart';
import 'package:blog_app_clean_tdd/core/error/exceptions.dart';
import 'package:blog_app_clean_tdd/core/error/failures.dart';
import 'package:blog_app_clean_tdd/core/network/connection_checker.dart';
import 'package:blog_app_clean_tdd/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app_clean_tdd/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_clean_tdd/features/blog/data/models/blog_model.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/entities/blog.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      BlogModel blog = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blog,
      );

      blog = blog.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blog);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!(await connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.getBlogs();

        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();

      blogLocalDataSource.cacheBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
