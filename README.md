# MovieAPI-SwiftData

MovieAPI-SwiftData is a simple mobile application developed in Swift using SwiftUI and SwiftData for persistence.
It allows users to discover the most popular and highly rated movies using the [The Movie Database (TMDb) API](https://www.themoviedb.org/documentation/api).
The app allows users to save their favorite movies.

## Features

- Browse a list of movies(top rated and popular)
- Access movies details
- Favorite movies

## Installation

1. Clone the repository
2. Open `MovieAPI-SwiftData` in Xcode
3. Build and run the app on a simulator or device

## Configuration

To use the app, you'll need to obtain an Access Token Auth from [TMDb](https://www.themoviedb.org/documentation/api)
Add it at info.plist where is written <ACCESS_TOKEN_AUTH_HERE> (image)

<img width="1531" alt="Captura de Tela 2024-05-22 às 09 45 05" src="https://github.com/MaThhiVick/MovieAPI-SwiftData/assets/83011790/fd392f7e-1505-40be-a45f-01e93c93e420">

The Authorization’s value field should be like this:

```swift
...
Bearer 123456789987654321
...
```
