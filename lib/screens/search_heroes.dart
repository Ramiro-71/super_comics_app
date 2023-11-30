import 'package:flutter/material.dart';
import 'package:super_comics_app/models/superhero.dart';
import 'package:super_comics_app/repositories/superhero_repository.dart';
import 'package:super_comics_app/services/superhero_service.dart';

class SearchHeroes extends StatefulWidget {
  const SearchHeroes({Key? key}) : super(key: key);

  @override
  State<SearchHeroes> createState() => _SearchHeroesState();
}

class _SearchHeroesState extends State<SearchHeroes> {
  SuperheroService? _superheroService;
  List<Superhero> heroes = [];

  final accessToken = "10157703717092094";
  final searchController = TextEditingController();

  @override
  void initState() {
    _superheroService = SuperheroService(accessToken);
    super.initState();
  }

  void searchHero(String name) async {
    if (name.isNotEmpty) {
      final searchResults = await _superheroService?.getByName(name) ?? [];
      if (mounted) {
        setState(() {
          heroes = searchResults;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          heroes = [];
        });
      }
    }
  }

  void onSearchButtonPressed() {
    searchHero(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Heroes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Hero',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSearchButtonPressed,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                return SuperheroItem(superhero: heroes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SuperheroItem extends StatefulWidget {
  final Superhero superhero;

  const SuperheroItem({Key? key, required this.superhero}) : super(key: key);

  @override
  State<SuperheroItem> createState() => _SuperheroItemState();
}

class _SuperheroItemState extends State<SuperheroItem> {
  bool isFavorite = false;

  initialize() async {
    isFavorite = await SuperheroRepository().isFavorite(widget.superhero!);

    if (mounted) {
      setState(() {
        isFavorite = isFavorite;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey);

    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(widget.superhero!.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gender: ${widget.superhero!.gender}"),
              Text("Intelligence: ${widget.superhero!.intelligence}"),
            ],
          ),
          leading: Image.network(widget.superhero!.imageUrl),
          trailing: IconButton(
            icon: icon,
            onPressed: () async {
              if (isFavorite) {
                await SuperheroRepository().delete(widget.superhero!);
              } else {
                await SuperheroRepository().insert(widget.superhero!);
              }
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ),
      ),
    );
  }
}
