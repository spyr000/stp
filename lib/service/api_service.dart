import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/dto/response_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://ru.wikipedia.org/w/api.php")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/?format=json&"
      "formatversion=2&"
      "action=query&"
      "uselang=user&"
      "generator=random&"
      "grnnamespace=0&"
      "grnlimit=10&"
      "piprop=original&"
      "pilimit=10&"
      "inprop=url&"
      "prop=pageterms|pageimages|info")
  Future<ResponseModel> fetchFeedData();

  @GET("/?format=json&"
      "formatversion=2&"
      "action=query&"
      "pageids={pageids}&"
      "uselang=user&"
      "piprop=original&"
      "pilimit=10&"
      "inprop=url&"
      // "exintro=1&"
      "prop=extracts|pageterms|pageimages|info")
  Future<ResponseModel> fetchPagesData(@Path("pageids") Object pageids);

  Future<ResponseModel> fetchSpecifiedPagesData(List<int> pageids) {
    var pageidsParam = pageids.map((id) => id.toString()).join('|');
    return fetchPagesData(pageidsParam);
  }
}
