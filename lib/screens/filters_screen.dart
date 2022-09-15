import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
          actions: [
            IconButton(
                enableFeedback: true,
                onPressed: () {
                  final snackBar = SnackBar(
                    content: const Text('Filters saved'),
                    action: SnackBarAction(onPressed: ()=>{}, label: '',),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjus your meal selection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten Free',
                    'Only include gluten free meals',
                    _glutenFree,
                    (newVal) {
                      setState(() {
                        _glutenFree = newVal;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose Free',
                    'Only include lactose free meals',
                    _lactoseFree,
                    (newVal) {
                      setState(() {
                        _lactoseFree = newVal;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _vegetarian,
                    (newVal) {
                      setState(() {
                        _vegetarian = newVal;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                      'Vegan', 'Only include vegan meals', _vegan, (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  SwitchListTile _buildSwitchListTile(
      String title, String description, bool currentVal, Function updateVal) {
    return SwitchListTile(
      enableFeedback: true,
      activeColor: Theme.of(context).colorScheme.secondary,
      value: currentVal,
      onChanged: (newVal) => updateVal(newVal),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
