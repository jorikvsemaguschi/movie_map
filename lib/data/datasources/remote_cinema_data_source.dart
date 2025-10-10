import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/cinema_response.dart';

part 'remote_cinema_data_source.g.dart';

// Retrofit API interface for fetching cinemas
@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/place")
abstract class RemoteCinemaDataSource {
  factory RemoteCinemaDataSource(Dio dio, {String baseUrl}) =
  _RemoteCinemaDataSource;

  @GET("/nearbysearch/json")
  Future<CinemaResponse> fetchCinemasNearby(
      @Query("location") String location,
      @Query("radius") int radius,
      @Query("type") String type,
      @Query("key") String apiKey,
      );
}

