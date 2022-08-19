import 'package:cabby/rider/config/config.dart';
import 'package:flutter/material.dart';

class Destination extends StatefulWidget {
  const Destination({Key? key}) : super(key: key);

  @override
  DestinationState createState() => DestinationState();
}

class DestinationState extends State<Destination> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {

  const Body({Key? key}) : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final accountNumber = TextEditingController();
  final accountNamr = TextEditingController();

  bool loading = false;
  bool? isEnabled = false;
  var carColour = [
    "Select Bank",
    "Economy",
    "Classic",
  ];
  var selectColour = 'Select Bank';

  @override
  Widget build(BuildContext context) {
    mediaHeight = MediaQuery.of(context).size.height;
    mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text('Destination',
            style: Config.style(FontWeight.w500, Colors.black, 20)),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                  // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: buildTextFormField('', accountNumber,
                        'Enter Destination', TextInputType.name),
                  ),
                  SizedBox(height: mediaHeight* 0.1),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Color(0xff7B7896),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home',
                                  style: Config.style(FontWeight.bold,
                                      const Color(0xff7B7896), 14)),
                              Text('No. 35 Ajose Adeogun Street, Utako',
                                  style: Config.style(FontWeight.bold,
                                      const Color(0xff7B7896), 14))
                            ]),
                        const Expanded(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        const Icon(Icons.edit, color: Color(0xff7B7896)),
                      ],
                    ),
                  ),
                    ),
                  ),
                  SizedBox(height: mediaHeight* 0.3),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.history,
                          color: Color(0xff7B7896),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home',
                                  style: Config.style(FontWeight.bold,
                                      const Color(0xff7B7896), 14)),
                              Text('No. 35 Ajose Adeogun Street, Utako',
                                  style: Config.style(FontWeight.bold,
                                      const Color(0xff7B7896), 14))
                            ]),
                        const Expanded(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTextFormField(text1, controller, hint, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
        ),
        SizedBox(
          height: mediaHeight* 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,

                // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  //borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hint),
          ),
        ),
      ],
    );
  }

  BuildContext? buildContext;
  Future webCall() async {
    // Showing CircularProgressIndicator using State.
  }
}
