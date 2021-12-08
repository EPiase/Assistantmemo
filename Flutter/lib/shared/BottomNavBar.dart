import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.stickyNote,
            size: 20,
          ),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.microphoneAlt,
            size: 20,
          ),
          label: 'Record',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.userCircle,
            size: 20,
          ),
          label: 'Profile',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // Navigator.popUntil(context, ModalRoute.withName('/Notes'));
            final newRouteName = "/Notes";
            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });

            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }
            break;
          case 1:
            Navigator.pushNamed(context, '/Record');
            break;
          case 2:
            Navigator.pushNamed(context, '/Profile');
            break;
        }
      },
    );
  }
}
