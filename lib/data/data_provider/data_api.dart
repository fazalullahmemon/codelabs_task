import 'package:codelabs_task/data/model/data_model.dart';
import 'package:http/http.dart' as http;

class DataFetchApi {
  Future fetchNewsData() async {
    final response = await http.post(
      Uri.parse('https://api.first.org/data/v1/news'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final ApiNews apiNews = apiNewsFromJson(response.body);
    return apiNews;
  }
}
