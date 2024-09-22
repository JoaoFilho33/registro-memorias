import 'package:registro_memorias/models/place.dart';
import 'package:registro_memorias/screens/place_detail.dart';
import 'package:flutter/material.dart';

class ListaLugares extends StatelessWidget {
  const ListaLugares(
      {super.key, required this.places, required this.onRemovePlace});

  final List<Place> places;
  final Function(Place place) onRemovePlace;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "Nenhum Lugar Adicionado Ainda!",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onRemovePlace(places[index]);
            },
            color: Colors.redAccent,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => LugarDetalhes(
                  place: places[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
