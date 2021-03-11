import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'The Dhobi Service',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              children: [],
              leading: Icon(
                Icons.attach_money_sharp,
                size: 20,
                color: Colors.purple[900],
              ),
              title: Text(
                'Pricing',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[900],
                ),
              ),
            ),
            BrandDivider(),
            ExpansionTile(
              leading: Icon(
                Icons.help_sharp,
                size: 20,
                color: Colors.purple[900],
              ),
              title: Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[900],
                ),
              ),
            ),
            BrandDivider(),
            ExpansionTile(
              leading: Icon(
                Icons.local_laundry_service_sharp,
                size: 20,
                color: Colors.purple[900],
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[900],
                ),
              ),
            ),
            BrandDivider(),
            ExpansionTile(
              leading: Icon(
                Icons.privacy_tip_sharp,
                size: 20,
                color: Colors.purple[900],
              ),
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[900],
                ),
              ),
            ),
            BrandDivider(),
            ExpansionTile(
              leading: Icon(
                Icons.headset_mic_sharp,
                size: 20,
                color: Colors.purple[900],
              ),
              title: Text(
                'Customer Service',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple[900],
                ),
              ),
            ),
            BrandDivider(),
          ],
        ),
      ),
    );
  }
}
