import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_add.dart';
import 'edit_Itemdetails.dart';

class NotificationEdit extends StatefulWidget {
  // NotificationEdit({Key? key, required this.title}) : super(key: key);
  //final String title;
  NotificationEdit({Key? key}) : super(key: key);
  @override
  _NotificationEditState createState() => _NotificationEditState();
}

class _NotificationEditState extends State<NotificationEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAED),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFAED),
        title: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "",
                style: GoogleFonts.poppins(
                  //fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "Remind List",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddItemPage(),
                    ),
                  );
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
                  ' Edit Item Details',
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
         /* Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 0, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddItemPage(),
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
                      'Add Item',
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
          ),*/
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
      'laptop': MapEntry(Icons.business_center, Color.fromARGB(255, 0, 0, 0)),
      'key': MapEntry(Icons.vpn_key, Color.fromARGB(255, 0, 0, 0)),
      'document': MapEntry(Icons.description, Color.fromARGB(255, 0, 0, 0)),
      'water the plants': MapEntry(Icons.park, Color.fromARGB(255, 0, 0, 0)),
      'water': MapEntry(Icons.water_drop, const Color.fromARGB(255, 0, 0, 0)),
      'light': MapEntry(Icons.lightbulb, Color.fromARGB(255, 0, 0, 0)),
      'lock': MapEntry(Icons.lock, const Color.fromARGB(255, 0, 0, 0)),
      'gas': MapEntry(Icons.local_gas_station, Color.fromARGB(255, 0, 0, 0)),
      'wallet': MapEntry(
          Icons.account_balance_wallet, const Color.fromARGB(255, 0, 0, 0)),
    };

    MapEntry<String, MapEntry<IconData, Color>> taskEntry =
        taskIcons.entries.firstWhere(
      (entry) => taskName.toLowerCase().contains(entry.key),
      orElse: () => MapEntry('', MapEntry(Icons.error, Colors.black)),
    );

    IconData icon = taskEntry.value.key;
    Color iconColor = taskEntry.value.value;

    return GestureDetector(
      onTap: () {
        // Navigate to the details page and pass necessary information
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsPage(
              location: location,
              taskName: taskName,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Card(
          color: Color(0xFFFEFAED),
          child: Container(
            padding: const EdgeInsets.only(
                left: 15, top: 0.0, bottom: 0.0, right: 10),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFFF1F3E6),
            ),
            child: Row(
              children: [
                // First Column: Icon
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(
                      left: 0, top: 0.0, bottom: 0.0, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFE6E9D6),
                  ),
                  child: Icon(
                    icon,
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
                    alignment: Alignment.topRight,
                    children: [
                      Positioned(
                        child: IconButton(
                          icon: Icon(Icons.edit_note),
                          onPressed: () {
                            // Handle onPressed event
                          },
                          color: const Color.fromARGB(255, 24, 24, 24),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      Color.fromARGB(255, 246, 150, 255),
      Color.fromARGB(255, 21, 142, 255),
    ],
  ),
  TaskInfo(
    location: 'Home',
    colors: [
      Color.fromARGB(255, 253, 225, 100),
      Color.fromARGB(255, 252, 92, 34),
    ],
  ),
  TaskInfo(
    location: 'School',
    colors: [
      Color.fromARGB(255, 130, 215, 255),
      Color.fromARGB(255, 23, 207, 38),
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
      'laptop': MapEntry(Icons.business_center, Color.fromARGB(255, 0, 0, 0)),
      'key': MapEntry(Icons.vpn_key, Color.fromARGB(255, 0, 0, 0)),
      'document': MapEntry(Icons.description, Color.fromARGB(255, 0, 0, 0)),
      'water the plants': MapEntry(Icons.park, Color.fromARGB(255, 0, 0, 0)),
      'water': MapEntry(Icons.water_drop, const Color.fromARGB(255, 0, 0, 0)),
      'light': MapEntry(Icons.lightbulb, Color.fromARGB(255, 0, 0, 0)),
      'lock': MapEntry(Icons.lock, const Color.fromARGB(255, 0, 0, 0)),
      'gas':
          MapEntry(Icons.local_gas_station, const Color.fromARGB(255, 0, 0, 0)),
      'wallet': MapEntry(
          Icons.account_balance_wallet, const Color.fromARGB(255, 0, 0, 0)),
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
