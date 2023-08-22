import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/api_implementer.dart';
import 'package:nkm_nose_pins_llp/modules/design_article/models/design_article_model.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class DesignArticleController extends GetxController {
  final RxBool isLoadingArticleList = true.obs;
  final RxString errorStringWhileLoadingArticleList = ''.obs;
  late DesignArticleModel designArticleListModel;
  RxList<ArticleDetail> articleList = <ArticleDetail>[].obs;

  void getCategoryArticleListApiCall({
    required int designId,
  }) async {
    try {
      articleList.clear();
      isLoadingArticleList.value = true;
      errorStringWhileLoadingArticleList.value = '';
      designArticleListModel =
          await ApiImplementer.getDesignArticleApiCall(designId: designId);
      if (designArticleListModel.success) {
        isLoadingArticleList.value = false;
        errorStringWhileLoadingArticleList.value = '';
        if(designArticleListModel.data != null){
          articleList.addAll(designArticleListModel.data!.articleDetail);
        }
        return;
      }
      isLoadingArticleList.value = false;
      errorStringWhileLoadingArticleList.value = designArticleListModel.message;
      return;
    } on DioException catch (dioError) {
      errorStringWhileLoadingArticleList.value = Helper.getErrMsgFromDioError(
        dioError: dioError,
      );
      isLoadingArticleList.value = false;
    } catch (error) {
      errorStringWhileLoadingArticleList.value = error.toString();
      isLoadingArticleList.value = false;
    }
  }

  void refreshArticleListApiCall(
      {required int articleId, required int designId}) async {
    articleList.removeWhere((element) => element.id == articleId);
    designArticleListModel =
        await ApiImplementer.getDesignArticleApiCall(designId: designId);
    if (designArticleListModel.success) {
      isLoadingArticleList.value = false;
      errorStringWhileLoadingArticleList.value = '';
      articleList.clear();
     if(designArticleListModel.data != null){
       articleList.addAll(designArticleListModel.data!.articleDetail);
     }
    }
  }
}
