import 'package:custom_bottom_navigation_bar/directory_page.dart';
import 'package:custom_bottom_navigation_bar/home_page.dart';
import 'package:custom_bottom_navigation_bar/lounge_page.dart';
import 'package:custom_bottom_navigation_bar/more_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_navbar_index_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Bottom Navigation Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NavbarIndexController indexController = Get.put(NavbarIndexController());
  // int navIndex = 0;

  final List<Widget> _children = [
    Home(),
    LoungePage(),
    Directory(),
    MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: indexController.index.value == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            indexController.index.value = 0;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            bottomNavigationBar: Obx(() {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: indexController.index.value,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.contact_emergency), label: "Contact"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Person"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store_mall_directory),
                      label: "Directory")
                ],
                onTap: (int index) {
                  indexController.index.value = index;
                },
              );
            }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return _children[indexController.index.value];
                })
              ],
            )),
      );
    });
  }
}
