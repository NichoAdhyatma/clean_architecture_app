import 'package:blog_app_clean_tdd/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  List<BlogModel> getBlogs();

  void cacheBlogs({required List<BlogModel> blogs});
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);

  @override
  void cacheBlogs({required List<BlogModel> blogs}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put('$i', blogs[i].toJson());
      }
    });
  }

  @override
  List<BlogModel> getBlogs() {
    List<BlogModel> blogs = [];

    for (int i = 0; i < box.length; i++) {
      blogs.add(BlogModel.fromJson(box.get('$i')));
    }

    return blogs;
  }
}
