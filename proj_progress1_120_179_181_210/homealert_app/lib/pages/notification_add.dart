import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification.dart'; // Import the notification.dart file

class AddItemPage extends StatefulWidget {
  final String username;

  AddItemPage({required this.username, Key? key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay? alertTime;
  String itemName = '';
  String itemDescription = '';
  List<String> repeatOptions = [];
  String selectedRepeatOption = 'Never';

  Future<void> saveItemToFirebase(String itemName, String itemDescription,
      TimeOfDay? alertTime, List<String> repeatOptions) async {
    await FirebaseFirestore.instance.collection('Item').add({
      'itemName': itemName,
      'itemDescription': itemDescription,
      'alertTime': alertTime != null
          ? '${alertTime!.hour.toString().padLeft(2, '0')}:${alertTime!.minute.toString().padLeft(2, '0')}'
          : null,
      'repeatOptions': repeatOptions,
    });
  }

  void showRepeatOptionsDialog(BuildContext context) async {
    List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> selectedOptions =
            repeatOptions.toList(); // Create a copy of repeatOptions
        return AlertDialog(
          title: Text('Select Repeat Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: Text('Never'),
                    value: selectedOptions
                        .isEmpty, // Check if no options are selected
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions
                              .clear(); // Clear other options if "Never" is selected
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Sunday'),
                    value: selectedOptions.contains('Sun'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Sun');
                        else
                          selectedOptions.remove('Sun');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Monday'),
                    value: selectedOptions.contains('Mon'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Mon');
                        else
                          selectedOptions.remove('Mon');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Tuesday'),
                    value: selectedOptions.contains('Tue'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Tue');
                        else
                          selectedOptions.remove('Tue');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Wednesday'),
                    value: selectedOptions.contains('Wed'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Wed');
                        else
                          selectedOptions.remove('Wed');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Thursday'),
                    value: selectedOptions.contains('Thu'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Thu');
                        else
                          selectedOptions.remove('Thu');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Friday'),
                    value: selectedOptions.contains('Fri'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Fri');
                        else
                          selectedOptions.remove('Fri');
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Saturday'),
                    value: selectedOptions.contains('Sat'),
                    onChanged: (value) {
                      setState(() {
                        if (value!)
                          selectedOptions.add('Sat');
                        else
                          selectedOptions.remove('Sat');
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(selectedOptions); // Return selectedOptions
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        repeatOptions = result;
        selectedRepeatOption =
            repeatOptions.isEmpty ? 'Never' : repeatOptions.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAED),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFAED),
        title: Padding(
          padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
              Text(
                "Add Remind List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text("        "),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Input field for item name
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20.0, top: 3, bottom: 3, right: 20.0),
                child: TextFormField(
                  controller: nameController,
                  onChanged: (value) {
                    itemName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Item\'s name',
                    hintText: ' ',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Input field for item description
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20.0, top: 3, bottom: 3, right: 20.0),
                child: TextFormField(
                  controller: descriptionController,
                  onChanged: (value) {
                    itemDescription = value;
                  },
                  maxLines: 3, // Allow multiple lines for description
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: ' ',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Input field for alert time
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
              child: ListTile(
                title: Text(
                  'Alert Time',
                ),
                trailing: TextButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        alertTime = selectedTime;
                      });
                    }
                  },
                  child: Text(
                    alertTime != null
                        ? '${alertTime!.hour.toString().padLeft(2, '0')}:${alertTime!.minute.toString().padLeft(2, '0')}'
                        : 'Select Time',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            // Input field for repeat options
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
              child: ListTile(
                onTap: () {
                  showRepeatOptionsDialog(context);
                },
                title: Text(
                  'Repeat',
                ),
                trailing: Text(
                  selectedRepeatOption,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Button to save the item
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Save item to Firebase
                        saveItemToFirebase(itemName, itemDescription, alertTime,
                            repeatOptions);
                        nameController.clear();
                        descriptionController.clear();
                        setState(() {
                          alertTime = null;
                          repeatOptions
                              .clear(); // Clear the selected repeat options
                          selectedRepeatOption =
                              'Never'; // Reset selectedRepeatOption
                        });

                        // Navigate to the notification page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotificationDemo(username: widget.username),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12), // Button padding
                      ),
                      child: Text(
                        'Create New Item',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ), // Button text
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
