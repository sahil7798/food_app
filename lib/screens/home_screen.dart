import 'package:flutter/material.dart';
import 'package:food_app_assignment/constants.dart';
import 'package:get/get.dart';
import '../controller/get_data_controller.dart';
import '../controller/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String tokenID;
  late String emailID;

  void initState() {
    super.initState();

    Future token = SharedPrefrence().getToken();
    token.then((data) async {
      setState(() {
        tokenID = data;
        print(tokenID);
      });
    });

    Future email = SharedPrefrence().getEmail();
    email.then((data) async {
      setState(() {
        emailID = data;
        print(emailID);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mealController = Get.put(DataController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Home",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color(0xff764abc)),
                accountName: Text(
                  "Email: $emailID",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "Token: $tokenID",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    SharedPrefrence.logOut();
                  });
                },
              ),
            ],
          ),
        ),
        body: Obx(() => mealController.isLoading.value
            ? Center(
                child: AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: const Text("Loading...")),
                  ],
                ),
              ))
            : Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ListView.builder(
                    itemCount: mealController.meal.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    mealController.meal[index]["strMealThumb"]
                                        .toString(),
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mealController.meal[index]["strMeal"]
                                            .toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Category: ${mealController.meal[index]["strCategory"].toString()}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                        maxLines: 3,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Area: ${mealController.meal[index]["strArea"].toString()}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "Instructions: ${mealController.meal[index]["strInstructions"].toString()}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }))));
  }
}
