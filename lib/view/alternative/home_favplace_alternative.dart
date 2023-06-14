import 'package:favorite_places/riverpod/user_places.dart';
import 'package:favorite_places/view/alternative/add_favplace_alternative.dart';
import 'package:favorite_places/widgets/alternative/places_list_alternative.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFavoritePlaceAlternative extends ConsumerStatefulWidget {
  const HomeFavoritePlaceAlternative({super.key});

  @override
  ConsumerState<HomeFavoritePlaceAlternative> createState() =>
      _HomeFavoritePlaceAlternativeState();
}

class _HomeFavoritePlaceAlternativeState
    extends ConsumerState<HomeFavoritePlaceAlternative> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();

    _placesFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PlacesListAlternative(places: addedPlaces),
      ),
    );
  }
}
