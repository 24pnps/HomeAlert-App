import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_add.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_Itemdetails.dart';

class NotificationEdit extends StatefulWidget {
  final String username;
  final String itemName;

  NotificationEdit({Key? key, required this.username, required this.itemName})
      : super(key: key);

  @override
  _NotificationEditState createState() => _NotificationEditState();
}

class _NotificationEditState extends State<NotificationEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay? alertTime;

  String itemName = '';
  String itemDescription = '';
  String selectedRepeatOption = 'Never';
  List<String> repeatOptions = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      // Query Firestore to get the document with the specified itemName
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Item')
              .where('itemName', isEqualTo: widget.itemName)
              .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Extract data from the document
        var data = querySnapshot.docs.first.data();
        itemName = data['itemName'];
        itemDescription = data['itemDescription'];
        String alertTimeString = data['alertTime'];
        repeatOptions = List<String>.from(data['repeatOptions']);

        // Update the state with the fetched data
        setState(() {
          nameController.text = itemName;
          descriptionController.text = itemDescription;
          if (alertTimeString != null && alertTimeString.isNotEmpty) {
            var timeParts = alertTimeString.split(':');
            int hour = int.parse(timeParts[0]);
            int minute = int.parse(timeParts[1]);
            alertTime = TimeOfDay(hour: hour, minute: minute);
          }
          selectedRepeatOption =
              repeatOptions.isEmpty ? 'Never' : repeatOptions.join(', ');
        });
      } else {
        print('Document not found');
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  void showRepeatOptionsDialog(BuildContext context) async {
    List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> selectedOptions = repeatOptions.toList();
        return AlertDialog(
          title: Text('Select Repeat Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: Text('Never'),
                    value: selectedOptions.isEmpty,
                    onChanged: (value) {
                      setState(() {
                        selectedOptions.clear();
                      });
                    },
                  ),
                  // Add other repeat options checkboxes here
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedOptions);
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

  Future<void> updateItemInFirebase() async {
    try {
      // Query Firestore to get the document with the specified itemName
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Item')
              .where('itemName', isEqualTo: widget.itemName)
              .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Extract document ID
        String docId = querySnapshot.docs.first.id;

        // Update item data
        await FirebaseFirestore.instance.collection('Item').doc(docId).update({
          'itemName': nameController.text,
          'itemDescription': descriptionController.text,
          'alertTime': alertTime != null
              ? '${alertTime!.hour.toString().padLeft(2, '0')}:${alertTime!.minute.toString().padLeft(2, '0')}'
              : null,
          'repeatOptions': repeatOptions,
        });

        print('Item updated successfully');
      } else {
        print('Document not found');
      }
    } catch (error) {
      print("Error updating item: $error");
    }
  }

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
                  fontSize: 20,
                ),
              ),
              Text(
                "Edit Item",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "           ",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                ),
              ),
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
                    setState(() {
                      itemName = value;
                    });
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
                    setState(() {
                      itemDescription = value;
                    });
                  },
                  maxLines: 3,
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
                title: Text('Alert Time'),
                trailing: TextButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: alertTime ?? TimeOfDay.now(),
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
                title: Text('Repeat'),
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
                        // Update item in Firebase
                        updateItemInFirebase();
                        // Clear text fields and reset state
                        nameController.clear();
                        descriptionController.clear();
                        setState(() {
                          alertTime = null;
                          repeatOptions.clear();
                          selectedRepeatOption = 'Never';
                        });
                        // Navigate back to notification page
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Edit Item',
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
