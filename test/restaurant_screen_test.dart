import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/restaurant_screen/restaurant_screen.dart';

void main() {
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
          (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.phone,
            Device.iphone11,
          ])
          ..addScenario(
            widget: const RestaurantScreen(testName: 'Normal Restaurant Name', alias: 'north-india-restaurant-san-francisco'),
            name: 'yelp app bar normal title',
          );

        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(tester, 'yelp_app_bar_normal_title');
      });
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
          (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.phone,
            Device.iphone11,
          ])
          ..addScenario(
            widget: const RestaurantScreen(testName: 'A Really Super Long Restaurant Name', alias: 'north-india-restaurant-san-francisco'),
            name: 'yelp app bar long title',
          );

        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(tester, 'yelp_app_bar_long_title');
      });
}