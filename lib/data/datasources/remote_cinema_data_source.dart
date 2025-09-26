import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/cinema_response.dart';

part 'remote_cinema_data_source.g.dart';

@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/place")
abstract class RemoteCinemaDataSource {
  factory RemoteCinemaDataSource(Dio dio, {String baseUrl}) =
  _RemoteCinemaDataSource;

  @GET("/nearbysearch/json")
  Future<CinemaResponse> fetchCinemasNearby(
      @Query("location") String location, // "lat,lng"
      @Query("radius") int radius, // meters
      @Query("type") String type, // "movie_theater"
      @Query("key") String apiKey,
      );
}

