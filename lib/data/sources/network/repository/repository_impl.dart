import 'package:tr_store/data/sources/network/API/api_client.dart';
import 'package:tr_store/data/models/product_model.dart';
import '../API/api_endpoints.dart';
import '../API/api_response.dart';
import '../API/base_url.dart';
import 'repository.dart';

class RepositoryImpl implements Repository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response<List<Products>>> fetchProducts() async {
    final Response response = await _apiClient.get(
      url: '${BaseURL.baseURL}${Endpoints.projects}',
    );
    
    return Response(
        productFromJson(response.body), response.statusCode, response.headers);
  }
}
