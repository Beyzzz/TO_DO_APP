import 'package:flutter/material.dart';

import '../screen/categories_screen.dart';
import '../screen/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Beyzanur Çetin"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://yt3.ggpht.com/a/AATXAJxRXmkWGv4_OxYgz3ILEKx06Gw4ez7MGkfrHw=s900-c-k-c0xffffffff-no-rj-mo"),
              ),
              accountEmail: Text("admin"),
              decoration: (BoxDecoration(color: Colors.blue)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Categories"),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
