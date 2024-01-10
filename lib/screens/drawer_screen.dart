import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children:  <Widget>[
          // const UserAccountsDrawerHeader(
          //   accountName: Text("Kucing Imut"),
          //   accountEmail: Text("0 Coins"),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: AssetImage('assets/img/kucing_imut.png'),
          //   ),
          // ),
          DrawerListTile(
            iconData: Icons.home,
            title: "Home",
            onTitlePressed:(){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/main_screen");
            }
          ),
          DrawerListTile(
            iconData: Icons.person_2_rounded,
            title: "Profile",
            onTitlePressed:(){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/profile_screen");
            }
          ),
          // DrawerListTile(
          //   iconData: Icons.favorite,
          //   title: "Popular Post",
          //   onTitlePressed:(){}
          // ),
          // DrawerListTile(
          //   iconData: Icons.location_history,
          //   title: "Nearby Post",
          //   onTitlePressed:(){}
          // ),
          DrawerListTile(
            iconData: Icons.people_alt_sharp,
            title: "Users",
            onTitlePressed:(){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/users_screen");
            }
          ),
          // DrawerListTile(
          //   iconData: Icons.card_giftcard,
          //   title: "Gift",
          //   onTitlePressed:(){}
          // ),
          // DrawerListTile(
          //   iconData: Icons.settings,
          //   title: "Settings",
          //   onTitlePressed:(){}
          // ),
          // DrawerListTile(
          //   iconData: Icons.logout_outlined,
          //   title: "Logout", 
          //   onTitlePressed:(){}
          // ),
        ],
      ),
    );
  }
}


class DrawerListTile extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final VoidCallback? onTitlePressed;
  // ignore: use_key_in_widget_constructors
  const DrawerListTile({
    Key? key,
    this.iconData,
    this.title,
    this.onTitlePressed
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTitlePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title!,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}