# Yelp Review App

A mobile application using Flutter & Dart that displays nearby restaurants and their information. Selecting a restaurant navigates to another screen and displays the full restaurant details & reviews and its location on Google Maps.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This mobile application uses both Yelp and Google Maps API requests. I have provided the boilerplates for the API requests and backing data models, so you will need to generate the following keys:

### Yelp

1. Go to https://www.yelp.com/developers and sign up for a developer account
2. Follow the authentication guide on https://docs.developer.yelp.com/docs/fusion-intro and generate your API key
3. Create a file in the root section of `lib\services` and name it `secret_services.dart`
4. Paste the following code and insert the API key you generated in the previous step:

```
const yelpKey = 'YOUR KEY HERE';
```

### Google Maps

Note: Some information comes from the README for [Google Maps for Flutter](https://pub.dev/packages/google_maps_flutter).

1. Sign up and generate an API key at https://cloud.google.com/maps-platform/
2. Enable the Google Map SDK for Android and iOS
 
   *Edit the API key* 
   * Go to the [Google Developers Console](https://console.cloud.google.com/)
   * Choose the project that you want to enable Google Maps on
   * Select the navigation menu and then select "Google Maps"
   * Select "APIs" under the Google Maps menu
   * To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE"
   * To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE"
   * Make sure the APIs you enabled are under the "Enabled APIs" section

   For more details, see [Getting started with Google Maps Platform](https://developers.google.com/maps/gmp-get-started) 

3. Create a file in `android\app\src\main\res\values` and name it `strings.xml`
4. Paste the following code and insert the API key you generated in the previous step:

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="MAPS_KEY">YOUR KEY HERE</string>
</resources>
```

6. Create a file in `ios\Runner` and name it `secrets.swift`
7. Paste the following code and insert the API key you generated in the previous step:

```
struct Constants {
    static let MAP_KEY = "YOUR KEY HERE"
}
```

## Features

The app is comprised of 2 screens: the Tour Screen and Restaurant Screen. Both screens implement Bloc State Management and pull-to-refresh.

#### Tour Screen

#### Restaurant Screen


## Testing

There are 3 types of testing available: Golden (snapshot), Unit, and Widget tests.

### Golden

Golden tests generate a sample image of a screen, then compares the rendered screen (or widget) with the sample image. I have implemented goldens tests to verify rendering for both the Tour Screen & Restaurant Screen.

#### Tour Screen Goldens
![](https://imgur.com/XbvLf89.png)

#### Restaurant Screen Goldens
![](https://imgur.com/lEocmgs.png)

### Unit

Unit tests verify the behavior of a function, method, or class. I have implemented unit tests to verify the 3 states of each screen (the Error, Loading, and Loaded states). You can see each state of each screen in the Golden test images above.

#### Widget

Widget tests do exactly as they imply - they test a single widget for its functionality and appearance. I have implemented the following 2 widget tests:

1. `restaurant_expansion_tile_test.dart`

This tests the dropdown menu in the Restaurant Screen (that displays the restaurant's hours) to make sure the expansion tile generates & renders the correct hours for the restaurant. Some restaurants may have atypical schedules, so there are 2 tests: one to test when the hours are given and one when they are not (this data is based on the response from the Yelp API).

2. `review_builder_test.dart` 

This tests the reviews section in the Restaurant Screen to make sure the review tiles are generated & rendered.

## Built With

* [Flutter](https://flutter.dev/) - Mobile framework
* [Yelp REST & GraphQL](https://maven.apache.org/) - Data for project  
* [Google Maps](https://developers.google.com/maps) - Map data for project
