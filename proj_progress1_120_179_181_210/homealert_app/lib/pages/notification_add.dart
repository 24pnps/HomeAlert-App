import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddItemPage extends StatelessWidget {
  // final String data;
  // const AddItemPage({Key? key, required this.data}) : super(key: key);
  const AddItemPage({Key? key}) : super(key: key);

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
              Text(
                "",
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
                    'Hi, !',
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
              color: Color(0xFFFEFAED),
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
                            'Location',
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
              color: Color(0xFFFEFAED),
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
                            'Item\'s Name',
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
                color: Color(0xFFFEFAED),
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

            SizedBox(height: 20),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
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
                            'February 27, 2024 at 12:10:00 PM',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ), // End of Expanded
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
              color: Color(0xFFFEFAED),
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
                            'February 27, 2024 at 12:20:00 PM ',
                            style: TextStyle(
                              fontSize: 15,
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
            // Fourth Card
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFFFEFAED),
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
                        'Create New Item',
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
