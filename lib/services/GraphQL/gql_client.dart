import 'package:graphql/client.dart';
import 'package:location/location.dart';
import 'package:yelp_review/services/restaurant_catalog.dart';
import 'package:yelp_review/services/secret_services.dart';

class GraphQLCall {
  late GraphQLClient client;

  GraphQLCall() {
    final httpLink = HttpLink(
      'https://api.yelp.com/v3/graphql',
    );

    final authLink = AuthLink(
      getToken: () async => 'Bearer $yelpKey',
    );

    final Link link = authLink.concat(httpLink);

    client = GraphQLClient(
      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: link,
    );
  }

  Future<LocationData> initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        throw Exception('Failed to enable service');
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception('Failed to get permission');
      }
    }

    var loc = await location.getLocation();

    return loc;
  }

  Future<RestaurantCatalog> fetchCatalog() async {
    final location = await initLocationService();

    const String catalogQuery = r'''
    query fetchCatalog($latitude: Float!, $longitude: Float!) {
      search(latitude: $latitude, longitude: $longitude) {
        business {
          name
          alias
          price
          rating
          distance
          photos
          categories {
            title
          }
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(catalogQuery),
      variables: <String, dynamic>{
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Failed to load catalog');
    } else {
      return RestaurantCatalog.fromGraphQLJson(result.data!['search']);
    }
  }
}
