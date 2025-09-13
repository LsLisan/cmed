import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class ArticleController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var page = 0.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  Future<void> fetchArticles({bool isRefresh = false}) async {
    if (isLoading.value) return;
    if (isRefresh) {
      page.value = 0;
      hasMore.value = true;
      articles.clear();
    }
    if (!hasMore.value) return;

    try {
      isLoading.value = true;

      final response = await ApiService.getRequest(
        "posts",
        start: page.value * AppConstants.pageLimit,
        limit: AppConstants.pageLimit,
      );

      if (response.isNotEmpty) {
        articles.addAll(response.map((e) => Article.fromJson(e)).toList());
        page.value++;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load articles: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
