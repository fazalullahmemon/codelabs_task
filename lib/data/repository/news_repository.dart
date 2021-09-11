import 'package:codelabs_task/data/data_provider/data_api.dart';
import 'package:codelabs_task/data/model/data_model.dart';

class NewsRepository {
  final DataFetchApi dataFetchApi = DataFetchApi();
  Future<List<Datum>?> fetchNews() async {
    final ApiNews response = await dataFetchApi.fetchNewsData();
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
