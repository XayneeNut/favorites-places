
import 'package:favorite_places/models/http/favorite_place_http_model.dart';

class GettersHttp {
  final FavoritePlacesHttpModel favoritePlace;

  GettersHttp(this.favoritePlace);

    String get locationImage {
    final lat = favoritePlace.location.latitude;
    final long = favoritePlace.location.longitude;

    return 'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=300&center=lonlat:$long,$lat&zoom=14&marker=lonlat:$long,$lat;color:%23ff0000;size:medium|lonlat:$long,$lat;color:%23ff0000;size:medium&apiKey=c46b883adce04dcd9c70cfda39c9dd15';
  }
}
