import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/home_screen.dart';

void main() {
  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
          (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.phone,
            Device.iphone11,
          ])
          ..addScenario(
            widget: const HomeScreen(restaurantName: 'Normal Restaurant Name'),
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
            widget: const HomeScreen(restaurantName: 'A Really Super Long Restaurant Name'),
            name: 'yelp app bar long title',
          );

        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(tester, 'yelp_app_bar_long_title');
      });
}