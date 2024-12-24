import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.blue, fontSize: 40),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/img1.png"),
                    radius: 30,
                  ),
                  Text(
                    "Metouekel Hajar",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "metouekelhajar@gmail.com",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //1
            ListTile(
                leading: Icon(Icons.home),
                title: Text("Covid Tracker"),
                onTap: () {
                  Navigator.pop(context);
                }), // context c l'objet courant,)

            //2
            ListTile(
                leading: Icon(
                  Icons.chat_bubble,
                  color: Colors.pink,
                ),
                title: Text("Emsi Chatbot"),
                onTap: () {
                  Navigator.pop(context);
                }),

            //3
            ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                }),

            //4
            ListTile(
                leading: Icon(Icons.settings, color: Colors.yellow),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                }),

            //5
            ListTile(
                leading: Icon(Icons.logout, color: Colors.deepPurple),
                title: Text("Log out"),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Center(
        child: Text(
            textAlign: TextAlign.center,
            "Welcome to the Home Page",
            style: TextStyle(color: Colors.pink, fontSize: 50)),
      ),
    );
  }
}
