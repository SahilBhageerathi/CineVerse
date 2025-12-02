# CineVerse

A Flutter application to discover movies using The Movie Database (TMDB) API.
The app supports Trending & Now Playing movie feeds, search, bookmarking, and movie details with persistent offline caching.


🚀 Features

| Feature                                | Status |
| -------------------------------------- | ------ |
| Trending Movies                        | ✔️     |
| Now Playing Movies                     | ✔️     |
| Search movies                          | ✔️     |
| Pagination / Load More                 | ✔️     |
| Offline Caching (Hive)                 | ✔️     |
| Bookmarks                              | ✔️     |
| Smooth Navigation & Custom Transitions | ✔️     |
| Responsive UI using ScreenUtil         | ✔️     |



🏛️ Architecture

The project is built using Clean Architecture + BLoC + Repository Pattern.

Presentation Layer → Bloc / UI
Domain Layer        → Repository / Models
Data Layer          → Dio + Retrofit API + Hive Local DB



## Getting Started

🔗 TMDB API

To run the project, create a .env file and add your TMDB API key and base url:
BASE_URL=https://api.themoviedb.org/3/
TMDB_ACCESS_TOKEN=your_api_key


▶️ Run the App

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run

