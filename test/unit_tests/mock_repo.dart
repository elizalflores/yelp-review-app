import 'package:mocktail/mocktail.dart';
import 'package:yelp_review/services/GraphQL/gql_client.dart';
import 'package:yelp_review/services/restaurant_repository.dart';

class MockGQLCall extends Mock implements GraphQLCall {}

class MockRESTCall extends Mock implements RestaurantRepository {}