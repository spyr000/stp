import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../dto/response_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://en.wikipedia.org/w/api.php")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/?format=json&formatversion=2&action=query&uselang=user&generator=random&grnnamespace=0&grnlimit=10&piprop=original&pilimit=10&exintro=1&inprop=url&prop=extracts|pageterms|pageimages|info")
  Future<ResponseModel> fetchData();
}