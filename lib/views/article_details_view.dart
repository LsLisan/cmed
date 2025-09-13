import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/download_controller.dart';
import '../models/article_model.dart';

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;
    final DownloadController controller = Get.put(DownloadController());

    final pdfUrl = article.downloadUrl ??
        "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

    return Scaffold(
      appBar: AppBar(title: Text("article_details".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(article.body),
              ),
            ),
            Obx(() => Column(
              children: [
                LinearProgressIndicator(
                  value: controller.isDownloading.value
                      ? controller.progress.value
                      : null,
                  minHeight: 5,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: controller.isDownloading.value
                        ? const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)
                        : const Icon(Icons.download),
                    label: Text(controller.isDownloading.value
                        ? "Downloading...".tr
                        : "download_file".tr),
                    onPressed: controller.isDownloading.value
                        ? null
                        : () => controller.downloadPdf(
                      pdfUrl,
                      "${article.title}.pdf",
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
