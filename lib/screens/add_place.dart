import 'package:registro_memorias/models/place.dart';
import 'package:registro_memorias/widgets/image_input.dart';
import 'package:registro_memorias/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registro_memorias/providers/user_places.dart';
import 'dart:io';

class AddLugarScreen extends ConsumerStatefulWidget {
  const AddLugarScreen({super.key});
  @override
  ConsumerState<AddLugarScreen> createState() {
    return _AddLugarScreenState();
  }
} 

class _AddLugarScreenState extends ConsumerState<AddLugarScreen> {
  final _titleController = TextEditingController();
  PlaceLocation? _selectedLocation;
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Por favor preencha todos os dados obrigatórios...")));
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Novo lugar favorito adicionado com sucesso!")));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Novo Lugar"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Nome da Memória"),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(
              height: 10,
            ),
            ImagemInput(onSelectedImage: (selectedImage) {
              _selectedImage = selectedImage;
            },),
            const SizedBox(
              height: 10,
            ),
            LocationInput(onSelectedLocation: (location) {
              _selectedLocation = location as PlaceLocation?;
            },),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: _savePlace,
              child: const Text(
                "Adicionar Lugar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
