import 'package:get/get.dart';
import '../services/download_service.dart';

class DownloadController extends GetxController {
  var isDownloading = false.obs;
  var progress = 0.0.obs;
  String? downloadedFilePath;

  Future<void> downloadPdf(String url, String fileName) async {
    isDownloading.value = true;
    progress.value = 0.0;

    try {
      final savedPath = await DownloadService.downloadFile(
        url: url,
        fileName: fileName,
        onProgress: (received, total) {
          if (total != -1) {
            progress.value = received / total;
          }
        },
      );

      downloadedFilePath = savedPath;
      Get.snackbar("Success", "Download complete!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isDownloading.value = false;
    }
  }
}
