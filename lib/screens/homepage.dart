import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/category.dart';
import 'package:test_project/category_repository.dart';
import 'package:test_project/screens/friendprofilepage.dart';
import 'package:test_project/screens/homepagemodel.dart';
import 'package:test_project/user.dart';
import 'package:test_project/user_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //User user;
  CategoryRepository categoryRepository;

  User user;

  @override
  void initState() {
    user = Provider.of<UserRepository>(context, listen: false).user;
    categoryRepository =
        Provider.of<CategoryRepository>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
        create: (BuildContext context) => HomePageModel(),
        child: Consumer<HomePageModel>(builder:
            (BuildContext context, HomePageModel homePageModel, Widget child) {
          return Scaffold(
              appBar: PreferredSize(
                  child: GestureDetector(
                    onTap: () {
                      print('test');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FriendProfilePage(
                                friendId: "1234",
                              )));
                      //Navigator.pushNamed(context, '/FriendProfilePage',
                      //  arguments: {'friendId': "1234"});
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                        ),
                        Positioned(
                          top: 40,
                          left: 120,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(user.userName,
                                    style:
                                        Theme.of(context).textTheme.headline1),
                                Text(user.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                            fontStyle: FontStyle.italic))),
                                Text(user.followers.toString() + " Followers",
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Text(user.points.toString() + " Brownie Points",
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                              ]),
                        ),
                        Positioned(
                            top: 40,
                            left: 20,
                            child: Icon(
                              Icons.account_circle,
                              size: 70,
                            ))
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(100)),
              body: GridView.builder(
                  itemCount: categoryRepository.getCategoryList().length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return mainCategoryItem(
                        context,
                        categoryRepository.getCategoryList()[index],
                        categoryRepository);
                  }));
        }));
  }
}

Widget mainCategoryItem(
    BuildContext context, RecipeCategory category, CategoryRepository repo) {
  return GestureDetector(
    onTap: () {
      repo.setCurrentCategory(category.categoryId);

      Navigator.pushNamed(context, '/Category');
    },
    child: Container(
      height: 200,
      width: 170,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/thumbnail.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            child: Text(category.categoryName),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    ), /*Card(
        color: Colors.blue,
        child: Stack(children: [
          Icon(Icons.account_circle),
          Container(
              //margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 80.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.redAccent,
              ),
              alignment: Alignment.bottomLeft,
              child: Text(category.categoryName,
                  style: TextStyle(color: Colors.black, fontSize: 20)))
        ])),*/
  );
}
