import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/home/tabs/add_todo.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/list_tab.dart';
import 'package:tooodooo/UI/screens/home/tabs/settings/settings_tab.dart';
import 'package:tooodooo/db/model/todo_dm.dart';
import 'package:tooodooo/db/model/user_dm.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';

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
        title: Text(
          'Welcome ${UserDM.currentUser?.userName}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: tabs[currentIndex],
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() => BottomAppBar(
    color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.12,
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
          await showModalBottomSheet(
            context: context,
            builder: (context) => const AddTodo(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: StadiumBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary, width: 3)),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );

  void signOut() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.signOut(context);
  }
}
