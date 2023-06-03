import 'package:favorite_places/riverpod/user_places.dart';
import 'package:favorite_places/view/alternative/add_favplace_alternative.dart';
import 'package:favorite_places/widgets/alternative/places_list_alternative.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFavoritePlaceAlternative extends ConsumerWidget {
  const HomeFavoritePlaceAlternative({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addedPlaces = ref.watch(userPlaceProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('favorite places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AddFavoritePlaceAlternative(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: PlacesListAlternative(places: addedPlaces));
  }
}
