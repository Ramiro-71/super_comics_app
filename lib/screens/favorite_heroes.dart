import 'package:flutter/material.dart';
import 'package:super_comics_app/models/superhero.dart';
import 'package:super_comics_app/repositories/superhero_repository.dart';

class FavoriteHeroes extends StatefulWidget {
  const FavoriteHeroes({Key? key}) : super(key: key);

  @override
  State<FavoriteHeroes> createState() => _FavoriteHeroesState();
}

class _FavoriteHeroesState extends State<FavoriteHeroes> {
  SuperheroRepository? _superheroRepository;
  List<Superhero>? _heroes;

  initialize() async {
    _heroes = await _superheroRepository?.getAll() ?? [];
    setState(() {
      _heroes = _heroes;
    });
  }

  @override
  void initState() {
    _superheroRepository = SuperheroRepository();
    initialize();
    super.initState();
  }

  void removeHero(int index) async {
    if (_heroes != null && _heroes!.isNotEmpty) {
      await _superheroRepository?.delete(_heroes![index]);
      setState(() {
        _heroes?.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Heroes"),
      ),
      body: ListView.builder(
        itemCount: _heroes?.length ?? 0,
        itemBuilder: ((context, index) {
          return Card(
            child: ListTile(
              title: Text(_heroes?[index].name ?? ""),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gender: ${_heroes?[index].gender}"),
                  Text("Intelligence: ${_heroes?[index].intelligence}"),
                ],
              ),
              leading: Image.network(_heroes?[index].imageUrl ?? ""),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeHero(index),
              ),
            ),
          );
        }),
      ),
    );
  }
}
