import 'package:favorite_places/riverpod/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFavoritePlaceAlternative extends ConsumerStatefulWidget {
  const AddFavoritePlaceAlternative({super.key});

  @override
  ConsumerState<AddFavoritePlaceAlternative> createState() =>
      _AddFavoritePlaceAlternativeState();
}

class _AddFavoritePlaceAlternativeState
    extends ConsumerState<AddFavoritePlaceAlternative> {
  final _nameController = TextEditingController();

  void _saveText() {
    final enteredTitle = _nameController.text;
    if (enteredTitle == '' || enteredTitle.isEmpty) {
      return;
    }

    ref.read(userPlaceProvider.notifier).addPlace(enteredTitle);

    Navigator.pop(context, enteredTitle);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new favorite place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Add New Place'),
              controller: _nameController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveText,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
