import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/category.dart';
import 'package:test_project/category_repository.dart';
import 'package:test_project/recipe_repository.dart';
import 'package:test_project/screens/categorypagemodel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<bool> isSelected = [];

  CategoryRepository categoryRepository;
  RecipeCategory recipeCategory;

  void _updateSelectedState(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  void initState() {
    //isSelected = [true, false, false];

    categoryRepository =
        Provider.of<CategoryRepository>(context, listen: false);

    recipeCategory = categoryRepository
        .getCategoryListByIndex(categoryRepository.getcurrentCategory());

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
              floatingActionButton: new FloatingActionButton(
                  elevation: 0.0,
                  child: new Icon(Icons.check),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {
                    for (var i = 0;
                        i < recipeCategory.categoryPreferences.length;
                        i++) {
                      if (isSelected[i]) {
                        categoryRepository.updateCategoryPrefs(
                            recipeCategory.categoryPreferences[i]);
                      }
                    }
                    Navigator.pushNamed(context, '/SubCategory');
                  }),
              backgroundColor: Colors.blue,
              body: Column(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      //color: Colors.cyan,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/thumbnail.png',
                              //height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                recipeCategory.categoryName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                      child: Text('Show all recipes containing',
                          style: Theme.of(context).textTheme.subtitle1),
                      alignment: Alignment.centerLeft),
                  Flexible(
                    flex: 2,
                    child: Wrap(
                        children: createInputs(context, _updateSelectedState,
                            isSelected, recipeCategory)),
                  )
                ],
              ));
        }));
    /*return */
  }
}

List<Widget> createInputs(
    context, callBack, isSelected, RecipeCategory recipeCategory) {
  var widgets = List<Widget>();

  if (isSelected.length == 0) {
    for (var i = 0; i < recipeCategory.categoryPreferences.length; i++) {
      if (i == 0) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }
  for (var i = 0; i < recipeCategory.categoryPreferences.length; i++) {
    // widgets.add(new InterestItem());
    widgets.add(GestureDetector(
        onTap: () {
          callBack(i);
        },
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3.0,
                  color: isSelected[i] ? Colors.red : Colors.amber)),
          child: Text(recipeCategory.categoryPreferences[i],
              style: Theme.of(context).textTheme.subtitle1),
        )));
  }
  return widgets;
}
