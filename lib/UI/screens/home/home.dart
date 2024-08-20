import 'package:flutter/material.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/list_tab.dart';
import 'package:tooodooo/UI/screens/home/tabs/settings/settings_tab.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';
import '../add_bottom_sheet/add_bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  GlobalKey<ListTabState> listTabKey = GlobalKey();
  List<Widget> tabs = [];

  @override
  void initState() {
    super.initState();
    tabs = [ListTab(key: listTabKey), const SettingsTab()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'To Do List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomNavigation(),
        body: tabs[currentIndex]);
  }

  Widget buildBottomNavigation() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (tappedIndex) {
              currentIndex = tappedIndex;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: "List"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Settings")
            ]),
      );

  buildFloatingActionButton() => FloatingActionButton(
        onPressed: () async {
          await AddBottomSheet.show(context);
          listTabKey.currentState?.gettodosListFromFireStore();
        },
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        child: const Icon(Icons.add),
      );
}
