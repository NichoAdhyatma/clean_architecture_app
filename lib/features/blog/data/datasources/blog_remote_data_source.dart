import 'dart:io';

import 'package:blog_app_clean_tdd/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl(this.client);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await client.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await client.storage.from('blog_images').upload(
            blog.id,
            image,
          );

      return client.storage.from('blog_images').getPublicUrl(blog.id);
      
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}