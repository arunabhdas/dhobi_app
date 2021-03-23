import 'package:dhobi_app/admin_tabs/admin_delivery_tab.dart';
import 'package:dhobi_app/admin_tabs/admin_home_tab.dart';
import 'package:dhobi_app/admin_tabs/admin_pickup_tab.dart';
import 'package:dhobi_app/admin_tabs/admin_settings_tab.dart';
import 'package:dhobi_app/helpers/helpermethods.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  static final String id = 'adminMain';

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  int selectedIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    HelperMethods.getCurrentUserInfo();
    //HelperMethods.getProfilePictureLink();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            AdminHomeTab(),
            AdminPickupTab(),
            AdminDeliveryTab(),
            AdminSettingsTab()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'Account'),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.purple[900],
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          onTap: onItemClicked,
        ),
      ),
    );
  }
}
