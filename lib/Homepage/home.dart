import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  bool isLiked = false;

  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.yellow,
      Colors.brown,
      Colors.indigo,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'LITZ',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Text(
                    'LITZ',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Tech',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: colors[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "User ${index + 1}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },

                // Create a unique controller per StoryView instance
              ),
            ),
            SizedBox(height: 2),
            Divider(),

            //////////////
            Container(
              padding: EdgeInsets.all(10),
              // height: 400,
              width: double.infinity,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.asset(
                              'assets/dp.png',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          title: Text(
                            'Sarah Corner',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          trailing: Icon(Icons.more_vert, color: Colors.black),
                        ),

                        // Post Image
                        Image.network(
                          'https://images.unsplash.com/photo-1607746882042-944635dfe10e',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),

                        // Buttons Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                style: ButtonStyle(
                                  iconSize: MaterialStateProperty.all(30),
                                ),
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                              ),

                              SizedBox(width: 16),
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.black,
                                size: 26,
                              ),
                              SizedBox(width: 16),
                              Icon(Icons.send, color: Colors.black, size: 26),
                              Spacer(),
                              Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
