import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp()); // pass obj nuild from class constructor
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // class constructor of MyApp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor:
              const Color(0xFFF4F4EF), // Set background color
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          )),
      home: MyNotiPage(title: 'Product layout demo home page'),
    );
  }
}

class MyNotiPage extends StatelessWidget {
  MyNotiPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  //Navigator.pop(context);
                },
                color: const Color.fromARGB(255, 24, 24, 24),
              ),
              Text(
                "My Remind List",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(Icons.notifications_active),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color.fromARGB(255, 24, 24, 24),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: EdgeInsets.only(
                  top: 15.0, bottom: 10.0, left: 5.0, right: 5.0),
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 10.0, left: 25.0, right: 20.0),
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF5F33E1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your today's task\nalmost done!",
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFDEDBFF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "View Task",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5F33E1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 77,
                            height: 77,
                            child: CircularProgressIndicator(
                              value: 0.85,
                              strokeWidth: 10,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF7ED957)),
                            ),
                          ),
                          Text(
                            "85%",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              top: 17.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        child: Progress(
                          location: 'Office',
                          taskName: 'Take the laptop home',
                          progress: 0.7,
                        ),
                      ),
                      Container(
                        child: Progress(
                          location: 'Home',
                          taskName: 'Water the plants',
                          progress: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 17.0, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Task Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                  children: <Widget>[
                    Task(
                      taskName: "Bring Laptop",
                      location: "Office",
                    ),
                    Task(
                      taskName: "House Key",
                      location: "Home",
                    ),
                    Task(
                      taskName: "Tax Documentation",
                      location: "Office",
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 0, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddItemPage(data: 'Annie'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: Size(double.infinity, 50)),
                    child: Text(
                      'Edit List',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Task extends StatelessWidget {
  Task({Key? key, required this.location, required this.taskName})
      : super(key: key);

  final String location;
  final String taskName;

  @override
  Widget build(BuildContext context) {
    final Map<String, MapEntry<IconData, Color>> taskIcons = {
      'laptop': MapEntry(
          Icons.business_center, const Color.fromARGB(255, 235, 99, 144)),
      'key': MapEntry(Icons.vpn_key, Color.fromARGB(255, 115, 39, 202)),
      'document': MapEntry(Icons.description, Color.fromARGB(255, 250, 133, 0)),
      'water the plants':
          MapEntry(Icons.park, const Color.fromARGB(255, 62, 156, 65)),
      'water': MapEntry(Icons.water_drop, Colors.red),
      'light': MapEntry(Icons.lightbulb, Colors.blue),
      'lock': MapEntry(Icons.lock, Colors.yellow),
      'gas': MapEntry(Icons.local_gas_station, Colors.lightBlue),
      'wallet': MapEntry(Icons.account_balance_wallet, Colors.lightGreen),
    };

    MapEntry<String, MapEntry<IconData, Color>> taskEntry =
        taskIcons.entries.firstWhere(
      (entry) => taskName.toLowerCase().contains(entry.key),
      orElse: () => MapEntry('', MapEntry(Icons.error, Colors.black)),
    );

    IconData icon = taskEntry.value.key;
    Color iconColor = taskEntry.value.value;

    double progressPercentage = 100;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 0, top: 10.0, bottom: 10.0, right: 0),
          child: Row(
            children: [
              // First Column: Icon
              Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  size: 31,
                  color: iconColor,
                ),
              ),
              // Second Column: Task Name and Location
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1, // Set line height
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 92, 92, 92),
                        fontWeight: FontWeight.bold, // Set text to bold
                        fontSize: 12, // Set font size to 10
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              // Third Column: Circle to show progress
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        value: progressPercentage / 100,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                      ),
                    ),
                    Text(
                      '${progressPercentage.toInt()}%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                          color: const Color.fromARGB(255, 151, 151, 151)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskInfo {
  final String location;
  final List<Color> colors;

  TaskInfo({required this.location, required this.colors});
}

List<TaskInfo> taskInfoList = [
  TaskInfo(
    location: 'Office',
    colors: [
      Color.fromARGB(255, 231, 243, 255),
      Color.fromARGB(255, 65, 163, 255),
    ],
  ),
  TaskInfo(
    location: 'Home',
    colors: [
      Color.fromARGB(255, 255, 233, 225),
      Color.fromARGB(255, 255, 120, 71),
    ],
  ),
  TaskInfo(
    location: 'School',
    colors: [
      Color.fromARGB(255, 211, 255, 229),
      Color.fromARGB(255, 41, 255, 130),
    ],
  ),
];

class Progress extends StatelessWidget {
  Progress(
      {required this.location, required this.taskName, required this.progress});

  final String location;
  final String taskName;
  final double progress;

  Widget build(BuildContext context) {
    final Map<String, MapEntry<IconData, Color>> taskIcons = {
      'laptop': MapEntry(
          Icons.business_center, const Color.fromARGB(255, 235, 99, 144)),
      'key': MapEntry(Icons.vpn_key, Color.fromARGB(255, 115, 39, 202)),
      'document': MapEntry(Icons.description, Color.fromARGB(255, 250, 133, 0)),
      'water the plants':
          MapEntry(Icons.park, const Color.fromARGB(255, 62, 156, 65)),
      'water': MapEntry(Icons.water_drop, Colors.red),
      'light': MapEntry(Icons.lightbulb, Colors.blue),
      'lock': MapEntry(Icons.lock, Colors.yellow),
      'gas': MapEntry(Icons.local_gas_station, Colors.lightBlue),
      'wallet': MapEntry(Icons.account_balance_wallet, Colors.lightGreen),
    };

    MapEntry<String, MapEntry<IconData, Color>> taskEntry =
        taskIcons.entries.firstWhere(
      (entry) => taskName.toLowerCase().contains(entry.key),
      orElse: () => MapEntry('', MapEntry(Icons.error, Colors.black)),
    );

    IconData icon = taskEntry.value.key;
    Color iconColor = taskEntry.value.value;

    TaskInfo taskInfo = taskInfoList.firstWhere(
      (info) => info.location == location,
      orElse: () => TaskInfo(location: '', colors: [Colors.grey]),
    );

    return Container(
      height: 135,
      width: 240,
      margin: EdgeInsets.only(top: 9.0, bottom: 10.0, right: 10.0),
      child: Card(
        color: (taskInfo.colors.isNotEmpty ? taskInfo.colors[0] : Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, top: 20.0, bottom: 15.0, right: 19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 100, 100, 100),
                      fontSize: 12,
                    ),
                  ),
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                taskName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 124, 124, 124)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddItemPage extends StatelessWidget {
  final String data;
  const AddItemPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color.fromARGB(255, 24, 24, 24),
              ),
              Text(
                "Add Remind List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "        ",
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Location Card
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ' + data + '!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'Let\'s add the items :)',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 13, bottom: 13, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First Column (Icon)
                    Icon(Icons.location_on, size: 27, color: Colors.pink),
                    SizedBox(width: 15),
                    // Second Column (Two Rows of Text)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Row of Text (Font size 10, Gray color)
                          Text(
                            'Task\'s Location',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          // Second Row of Text (Font size 15)
                          Text(
                            'Office',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Third Column (Icon)
                    Icon(Icons.arrow_drop_down, size: 35),
                  ],
                ),
              ),
            ),

            // First Card
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 13, bottom: 13, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First Row of Text (Font size 10, Gray color)
                          Text(
                            'Task\'s Name',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 2),
                          // Second Row of Text (Font size 15)
                          Text(
                            'Take the laptop home',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Second Card
            SizedBox(
              height: 150, // Set the desired height
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 13, bottom: 13, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Row of Text (Font size 10, Gray color)
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Second Row of Text (Font size 15)
                      Text(
                        "Bring laptop home to work on project, need to present on Monday morning",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Third Card
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 13, bottom: 13, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First Column (Icon)
                    Icon(Icons.calendar_month,
                        size: 25, color: Color(0xFF5F33E1)),
                    SizedBox(width: 15),
                    // Second Column (Two Rows of Text)
                    Expanded(
                      // Modification: Wrapped in Expanded
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Row of Text (Font size 10, Gray color)
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          // Second Row of Text (Font size 15)
                          Text(
                            '03 May, 2024 01:00 pm',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ), // End of Expanded
                    // Third Column (Icon)
                    Icon(Icons.arrow_drop_down, size: 35),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 13, bottom: 13, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First Column (Icon)
                    Icon(Icons.calendar_month,
                        size: 25, color: Color(0xFF5F33E1)),
                    SizedBox(width: 15),
                    // Second Column (Two Rows of Text)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // First Row of Text (Font size 10, Gray color)
                          Text(
                            'End Date',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          // Second Row of Text (Font size 15)
                          Text(
                            '05 May, 2024 05:30 pm',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Third Column (Icon)
                    Icon(Icons.arrow_drop_down, size: 35),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            // Fourth Card
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 13, bottom: 13, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First Column (Text: Repeat)
                    Text(
                      'Repeat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 15),
                    // Second Column (Text: End Date and Icon)
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(
                            width: 90, // Adjust the width as needed
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 229, 221, 255),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns children along the main axis
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Never',
                                      textAlign: TextAlign
                                          .center, // Align text to the center
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF5F33E1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(double.infinity, 50)),
                      child: Text(
                        'Add List',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
