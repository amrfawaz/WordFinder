# Movie App

The Dictionary App is a SwiftUI-based application, a versatile and user-friendly application designed to help users look up word meanings, definitions, and examples. This app is perfect for students, writers, and anyone who loves words and wants to expand their vocabulary.



## Features
  - Contains textfiled that allow you to type any word and then when press enter, a list of words should be fetched from backend API.
  - By clicking on on any returned word in main screen you'll be navigated to screen for list of meaning of this clicked word.
  - By clicking on any meaning in meaning list, you'll be navigated to list of definitions that contains definision and exmple for the word.
  - In the main screen there are list of recent search history

## Requirements

- Xcode 15
- iOS SDK 15+
- Swift 5.9+

## Architecture

The app is built using the MVVM (Model-View-ViewModel) architecture pattern for presentation layer, following Domain-Driven Design principles. The codebase is organized into domain, data, and presentation layers.

- **Domain Layer**:
  - Contains domain models representing movie entities.
  - Includes use cases for fetching movie data.

- **Data Layer**:
  - Manages network requests and data retrieval from the TMDb API.
  - Recent search is cached in Realm DB.

- **Presentation Layer**:
  - Uses SwiftUI for creating views.
  - Uses Combine for view model bindings and logic.

- **Tests**: XCTest for Unit testing in Domain and Data layers.

### Folders structure ##

* Packages /Sources:
- AppConfigurations: The AppConstants enum in Swift is a convenient way to group a set of related constant values, making them easily accessible throughout the application. This enum is specifically used for storing various constants related to the TMDb API, such as URLs and HTTP headers.
- CoreInterface: Containt UI related logic and constants
- Networking: Using URLSession for a robust network layer.
- Search: Contains the main package of the app and contains all logic related to app.
