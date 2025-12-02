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

⚠️ Important Notes

🌍 TMDB API Availability in India
The TMDB API is restricted in India by multiple ISPs.
Because of this, the application will not work on Indian mobile networks unless you use a VPN.
👉 To run this app successfully on real devices in India:
Connect to a VPN (USA / UK / Singapore recommended)
Then open the app
The app works normally without VPN on most office Wi-Fi and international networks


🔗 Deep Linking Instructions

The application supports deep links for opening movie detail pages directly.
However, for Android to allow deep links from the browser or shared links automatically, you must manually enable supported links for the app:

App Info -> Open by default -> Add Link -> Allow "www.cineverse.com"






