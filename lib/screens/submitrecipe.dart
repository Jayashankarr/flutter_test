import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/popup/bluralertpopup.dart';
import 'package:test_project/recipe_repository.dart';
import 'package:test_project/screens/submitrecipemodel.dart';

/* PAGE WHERE USER CAN SUBMIT THE RECIPE BY PROVIDING THE TITLE DESCRIPTION ETC */

class SubmitRecipePage extends StatefulWidget {
  SubmitRecipePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SubmitRecipePageState createState() => _SubmitRecipePageState();
}

class _SubmitRecipePageState extends State<SubmitRecipePage> {
  File _image;

  List<bool> isSelected = [];

  List<String> _recipePrefs = [];

  // contains the ingrediants added by the user.
  var ingrediantsText = List<String>();

  // methods added by the user.
  var methodsText = List<String>();

  // methods added by the user.
  var tagsText = List<String>();

  // ingrediant currently added by the user.
  String txtIngrediantInput;
  // method currenntly added by the user.
  String txtMethodInput;
  // method currenntly added by the user.
  String txtTagInput;

  void _updateImages(File image) {
    setState(() {
      _image = image;
    });
  }

  void _updateSelectedState(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

// Function used to update the text.
  void updateTagText(index, str) {
    if (index >= 0) {
      tagsText[index] = str;
    } else {
      txtTagInput = str;
    }
  }

  // function to add the method added by the user to the list.
  void addTag() {
    if (txtTagInput != null && txtTagInput != "") {
      tagsText.add(txtTagInput);
      txtTagInput = "";
      setState(() {});
    }
  }

  // Function used to update the text.
  void updateMethodText(index, str) {
    if (index >= 0) {
      methodsText[index] = str;
    } else {
      txtMethodInput = str;
    }
  }

  // function to add the method added by the user to the list.
  void addMethod() {
    if (txtMethodInput != null && txtMethodInput != "") {
      methodsText.add(txtMethodInput);
      txtMethodInput = "";
      setState(() {});
    }
  }

  // update the ingrediant text
  void updateIngrediantText(index, str) {
    if (index >= 0) {
      ingrediantsText[index] = str;
    } else {
      txtIngrediantInput = str;
    }
  }

  // add the ingrediant text added by the user.
  void addIngrediant() {
    if (txtIngrediantInput != null && txtIngrediantInput != "") {
      ingrediantsText.add(txtIngrediantInput);
      txtIngrediantInput = "";
      setState(() {});
    }
  }

  @override
  void initState() {
    // to show 2 ingrediants by default
    ingrediantsText.add('');
    ingrediantsText.add('');

    methodsText.add('');
    methodsText.add('');

    _recipePrefs =
        Provider.of<RecipeRepository>(context, listen: false).getRecipePrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubmitRecipePageModel>(
        create: (BuildContext context) => SubmitRecipePageModel(),
        child: Consumer<SubmitRecipePageModel>(builder: (BuildContext context,
            SubmitRecipePageModel homePageModel, Widget child) {
          return Scaffold(
              backgroundColor: Colors.blueGrey,
              body: ListView(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: null,
                          child: Text('Submit \nYour Recipe',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        RaisedButton(
                          onPressed: null,
                          child: Text('View \nSubmitted Recipes',
                              style: Theme.of(context).textTheme.subtitle1),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                            text: 'RECIPE TITLE',
                            style: Theme.of(context).textTheme.headline1,
                            children: <TextSpan>[
                          TextSpan(
                              text: ' (max 50 characters)',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .merge(
                                      TextStyle(fontStyle: FontStyle.italic)))
                        ])),
                    txtPanel(MediaQuery.of(context).size.width * 0.9, 50, 1, "",
                        true),
                    IconButton(icon: Icon(Icons.camera), onPressed: null),
                    SizedBox(height: 20),
                    Text('PREPARATION TIME',
                        style: Theme.of(context).textTheme.headline1),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            txtPanel(MediaQuery.of(context).size.width * 0.3,
                                50, 1, "", true),
                            Positioned(
                                left: MediaQuery.of(context).size.width * 0.35,
                                top: 15,
                                child: Text('Minutes',
                                    style:
                                        Theme.of(context).textTheme.subtitle1))
                          ],
                        )),
                    SizedBox(height: 20),
                    Text('INGREDIANTS',
                        style: Theme.of(context).textTheme.headline1),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: showInputText(
                            'Ingrediant',
                            txtIngrediantInput,
                            ingrediantsText,
                            1,
                            50,
                            context,
                            addIngrediant,
                            updateIngrediantText)),
                    SizedBox(height: 20),
                    Text('METHODS',
                        style: Theme.of(context).textTheme.headline1),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: showInputText(
                            'Method',
                            txtMethodInput,
                            methodsText,
                            3,
                            86,
                            context,
                            addMethod,
                            updateMethodText)),
                    SizedBox(height: 20),
                    Text('COMMENT ABOUT YOUR DISH',
                        style: Theme.of(context).textTheme.headline1),
                    Text('(This will appear at the end of your recipe)',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(fontStyle: FontStyle.italic))),
                    txtPanel(MediaQuery.of(context).size.width * 0.9, 88, 3, "",
                        true),
                    SizedBox(height: 20),
                    Text('CHOOSE TAGS FOR YOUR DISH',
                        style: Theme.of(context).textTheme.headline1),
                    Text('(This helps other Chefs find your recipe easily)',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(fontStyle: FontStyle.italic))),

                    /*Flexible(
                      flex: 2,
                      child: Wrap(
                          children: createInputs(context, _updateSelectedState,
                              isSelected, _recipePrefs)),
                    )*/
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Wrap(
                              children: createInputs(
                                  context,
                                  _updateSelectedState,
                                  isSelected,
                                  _recipePrefs)),
                        )
                      ],
                    ),
                    Text('CANT FIND THE RIGHT TAG?',
                        style: Theme.of(context).textTheme.headline1),
                    Text('(Add new tags here that may best describe your dish)',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(fontStyle: FontStyle.italic))),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: showInputText(
                            'Tag',
                            txtIngrediantInput,
                            ingrediantsText,
                            1,
                            50,
                            context,
                            addIngrediant,
                            updateIngrediantText)),
                    SizedBox(height: 20),
                    Container(
                      decoration: _image == null
                          ? null
                          : BoxDecoration(
                              image: DecorationImage(image: FileImage(_image))),
                    ),
                    Center(
                      child: RaisedButton(
                          color: Colors.grey,
                          onPressed: () {
                            //_showDialog(context);
                            // _showSelectionDialog(context, _updateImages);
                          },
                          child: Text('SUBMIT RECIPE',
                              style: Theme.of(context).textTheme.headline1)),
                    ),
                  ],
                )
              ]));
        }));
  }
}

_showDialog(BuildContext context) {
  VoidCallback continueCallBack = () => {
        Navigator.of(context).pop(),
        // code on continue comes here
      };
  BlurryDialog alert = BlurryDialog(
      "",
      "DISCARD RECIPE",
      "SAVE RECIPE",
      "This looks like a great recipe! \n Are you sure you don't want to submit it?",
      continueCallBack);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

List<Widget> createInputs(
    context, callBack, isSelected, List<String> prefsList) {
  var widgets = List<Widget>();

  if (isSelected.length == 0) {
    for (var i = 0; i < prefsList.length; i++) {
      if (i == 0) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }
  for (var i = 0; i < prefsList.length; i++) {
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
          child:
              Text(prefsList[i], style: Theme.of(context).textTheme.subtitle1),
        )));
  }
  return widgets;
}

List<Widget> showInputText(
    String type,
    String txtInputLabel,
    List<String> ingrediantsTxt,
    int maxLines,
    double height,
    context,
    addFunction,
    updateFunction) {
  var items = List<Widget>();

  for (var i = 0; i < ingrediantsTxt.length; i++) {
    String hintTxt = "";

    if (ingrediantsTxt[i] == "") {
      hintTxt = type + i.toString();
    }
    items.add(txtPanelModified(
        MediaQuery.of(context).size.width * 0.7,
        height,
        maxLines,
        hintTxt,
        ingrediantsTxt[i],
        true,
        i,
        addFunction,
        updateFunction));

    items.add(SizedBox(height: 5));
  }

  var stack = Stack(children: <Widget>[
    txtPanel(MediaQuery.of(context).size.width, height, maxLines, "", false),
    txtPanelModified(MediaQuery.of(context).size.width * 0.7, height, maxLines,
        type, txtInputLabel, true, null, addFunction, updateFunction),
    Positioned(
        left: MediaQuery.of(context).size.width * 0.75,
        top: 10,
        child: GestureDetector(
            onTap: () {
              addFunction();
            },
            child: Container(
                child: Icon(
              Icons.control_point,
              size: 35,
            )))),
  ]);
  items.add(stack);

  return items;
}

Widget txtPanel(double width, double height, int maxLines, String hintTxt,
    bool showBorder) {
  return Container(
    decoration: BoxDecoration(
      border: showBorder ? Border.all(color: Colors.yellow) : null,
    ),
    height: height,
    width: width,
    child: TextField(
      maxLines: maxLines,
      decoration: showBorder ? InputDecoration(hintText: hintTxt) : null,
    ),
  );
}

Widget txtPanelModified(
    double width,
    double height,
    int maxLines,
    String hintTxt,
    String text,
    bool showBorder,
    int index,
    addContainer,
    updateContainer) {
  final _controller = TextEditingController(text: text);

  if (text != "" && text != null) {
    _controller.value = _controller.value.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
  if (index == null) index = -1;

  return Container(
    decoration: BoxDecoration(
      border: showBorder ? Border.all(color: Colors.yellow) : null,
    ),
    height: height,
    width: width,
    child: TextField(
        controller: _controller,
        maxLines: maxLines,
        decoration: showBorder
            ? InputDecoration(
                hintText: hintTxt,
                hintStyle: TextStyle(color: Colors.grey),
              )
            : null,
        onChanged: (String str) {
          updateContainer(index, str);
        },
        onEditingComplete: () {
          updateContainer(index, _controller.text);
          //FocusScope.of(context).requestFocus(FocusNode());
        },
        onSubmitted: (String str) {
          if (index == -1) addContainer();
          //FocusScope.of(context).requestFocus(FocusNode());
        }),
  );
}

/*Future getImage(callback) async {
  File _image;
  final picker = ImagePicker();

  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  _image = File(pickedFile.path);
  callback(_image);
}

Future<void> _showSelectionDialog(BuildContext context, callback) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("From where do you want to take the photo?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                getImage(callback);
              },
            ),
          ],
        );
      });
}*/
