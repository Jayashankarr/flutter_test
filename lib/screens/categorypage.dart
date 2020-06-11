import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/recipe_repository.dart';
import 'package:test_project/screens/categorypagemodel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<bool> isSelected = [];

  void _updateSelectedState(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  void initState() {
    //isSelected = [true, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => CategoryPageModel(
            Provider.of<RecipeRepository>(context, listen: false)),
        child: Consumer<CategoryPageModel>(builder: (BuildContext context,
            CategoryPageModel categoryPageModel, Widget child) {
          return Scaffold(
              body: Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.cyan,
                ),
              ),
              Align(
                  child: Text('Show all recipes containing'),
                  alignment: Alignment.centerLeft),
              Flexible(
                flex: 2,
                child: Wrap(
                    children: createInputs(_updateSelectedState, isSelected,
                        categoryPageModel.getRecipePrefs())),
              )
            ],
          ));
        }));
    /*return */
  }
}

List<Widget> createInputs(callBack, isSelected, List list) {
  var widgets = List<Widget>();

  if (isSelected.length == 0) {
    for (var i = 0; i < list.length; i++) {
      isSelected.add(false);
    }
  }
  for (var i = 0; i < list.length; i++) {
    // widgets.add(new InterestItem());
    widgets.add(GestureDetector(
        onTap: () {
          callBack(i);
        },
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: isSelected[i] ? Colors.red : Colors.amber)),
          child: Text(list[i]),
        )));
  }
  return widgets;
}
