import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cats/data/responses/fact_response.dart';

part 'cats_service.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com")
abstract class CatsService {
  factory CatsService(Dio dio, {String baseUrl}) = _CatsService;

  @GET("/facts/random?animal_type=cat&amount=1")
  Future<FactResponse> getFact();
}
