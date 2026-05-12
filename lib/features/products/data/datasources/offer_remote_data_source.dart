import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/api_endpoints.dart';
import '../models/offers_response_model.dart';

part 'offer_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class OfferRemoteDataSource {
  factory OfferRemoteDataSource(Dio dio, {String baseUrl}) =
      _OfferRemoteDataSource;

  @GET(ApiEndpoints.offers)
  @Headers({
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YjNlNDA0Zi1mNTBmLTRmODYtZjIwMy0wOGRlMDdjM2ZlMTMiLCJqdGkiOiJlMzI2NzNiOC01ZTQ2LTQ1YzEtOTlkNy1lNzM4MWY4ZmZlNDAiLCJlbWFpbCI6Im1lZGFmZTkzOTVAYXJxc2lzLmNvbSIsIm5hbWUiOiJNb2hhbWVkIFJhc2hhZCIsInJvbGVzIjoiIiwicGljdHVyZSI6IiIsImV4cCI6MTc2MDQwMDUwNywiaXNzIjoiZXNob3AubmV0IiwiYXVkIjoiZXNob3AubmV0In0.LNNoybBu3yv5woQ1pRWKrpCoH-Be4-KF4DuetpBunFM',
    'Content-Type': 'application/json',
  })
  Future<OffersResponseModel> getOffers(@Body() Map<String, dynamic> requestBody);
}
