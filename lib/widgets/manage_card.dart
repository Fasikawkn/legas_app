import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:flutter/material.dart';

class ManageCard extends StatelessWidget {
  String image;

  ManageCard({required this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("I am tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FundraiserDetail(),
          ),
        );
      },
      child: Container(
        color: Theme.of(context).backgroundColor,
        height: size.height * 0.55,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(bottom: 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: size.height * 0.35,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/$image',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.ios_share),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: SizedBox(
                        height: 30.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text("Published"),
                          onPressed: () {},
                        ),
                      ))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Support For The Russel Family",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                )),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "\$93,811 raised of \$75,000",
                  style: TextStyle(fontSize: 16.0),
                )),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: LinearProgressIndicator(
                value: 0.9,
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
