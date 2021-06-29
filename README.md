# Movie Colony

![ci](https://github.com/debbsefe/Movie-Colony/actions/workflows/movie_colony_ci.yml/badge.svg) [![codecov](https://codecov.io/gh/debbsefe/Movie-Colony/branch/main/graph/badge.svg?token=41VSAPPB8M)](https://codecov.io/gh/debbsefe/Movie-Colony)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

# Installing

#### _Prerequisites_

Ensure you have **Flutter** installed by entering `flutter -v` on your terminal
If you don't have **Flutter** installed, go to the [Flutter Website](http://flutter.dev), and follow the download instructions

To install this app

`git clone https://github.com/debbsefe/Movie-Colony`

And install the required dependencies

`flutter pub get`

Initiate code generation.

`flutter pub run build_runner build --delete-conflicting-outputs`

Run the app

`flutter run --no-sound-null-safety`

## Running the tests

To run test cases

`flutter test --no-sound-null-safety`

# App-Development-Info

_Folder Structure_

- core: contains all files that are reused throughout the app

  - error: exceptions and failure classes are located here
  - utils: general classes and constants used throughout the app are located here, such as app strings, extensions, app colors etc.

- feature: each feature that are available in the app are included here, and separated as folders

  - data: all calls made to the remote data/api are included here
  - domain: represents bridge between the data layer and presentation layer, here all abstractions are made before being sent to the presentation layer
  - presentation: includes all classes and methods that make up the screens/pages of the app.
