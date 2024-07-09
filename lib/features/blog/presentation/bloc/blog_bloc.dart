import 'dart:io';

import 'package:blog_app_clean_tdd/core/usecase/usecase.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/entities/blog.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app_clean_tdd/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlog;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>(
      (event, emit) => emit(
        BlogLoading(),
      ),
    );

    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAll>(_onBlogGetAll);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    response.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onBlogGetAll(
    BlogGetAll event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _getAllBlog(NoParams());

    response.fold(
      (failure) => emit(
        BlogFailure(
          failure.message,
        ),
      ),
      (blogs) => emit(
        BlogDisplaySuccess(blogs),
      ),
    );
  }
}
