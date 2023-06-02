import 'package:flutter/material.dart';

class AddFavoritePlaceAlternative extends StatefulWidget {
  const AddFavoritePlaceAlternative({super.key});

  @override
  State<AddFavoritePlaceAlternative> createState() => _AddFavoritePlaceAlternativeState();
}

class _AddFavoritePlaceAlternativeState extends State<AddFavoritePlaceAlternative> {
  final _nameController = TextEditingController();

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
                  onPressed: () {},
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
