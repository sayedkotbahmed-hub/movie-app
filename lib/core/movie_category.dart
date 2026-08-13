import 'package:flutter/material.dart';

enum MovieCategory { topRated, nowPlaying, comingSoon }

extension MovieCategoryLabel on MovieCategory {
  String get label {
    switch (this) {
      case MovieCategory.topRated:
        return 'Top Rated';
      case MovieCategory.nowPlaying:
        return 'Now Playing';
      case MovieCategory.comingSoon:
        return 'Coming Soon';
    }
  }
}

extension MovieCategoryEndpoint on MovieCategory {
  String get endpoint {
    switch (this) {
      case MovieCategory.topRated:
        return 'top_rated';
      case MovieCategory.nowPlaying:
        return 'now_playing';
      case MovieCategory.comingSoon:
        return 'upcoming';
    }
  }
}

extension MovieCategoryColor on MovieCategory {
  Color get color {
    switch (this) {
      case MovieCategory.topRated:
        return const Color.fromARGB(255, 3, 193, 171);
      case MovieCategory.nowPlaying:
        return const Color.fromARGB(255, 2, 112, 101);
      case MovieCategory.comingSoon:
        return const Color.fromARGB(255, 0, 101, 69);
    }
  }
}