import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enrolled Classes'),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Find Classes'),
                ),
              ],
            ),
            Container(
              height: 100,
              // margin: EdgeInsets.all(10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Physics',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text('Grade: 13')
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Get Link'))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
