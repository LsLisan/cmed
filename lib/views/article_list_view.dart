import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import '../routes/app_routes.dart';

class ArticleListView extends StatelessWidget {
  final ArticleController controller = Get.put(ArticleController());

  final ScrollController scrollController = ScrollController();

  ArticleListView({super.key}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          controller.hasMore.value) {
        controller.fetchArticles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () => controller.fetchArticles(isRefresh: true),
          child: ListView.builder(
            controller: scrollController,
            itemCount: controller.articles.length +
                (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.articles.length) {
                final article = controller.articles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(
                    article.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.articleDetails,
                      arguments: article,
                    );
                  },
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
