import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: nameController,
          onChanged: (String value) {},
          cursorColor: Colors.deepOrange,
          decoration: const InputDecoration(
              hintText: "Name",
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 15,
                  color: Color(0xff020529),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
 const InputPassword({
    Key? key,
    this.passwordController,
  }) : super(key: key);

  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: passwordController,
          obscureText: true,
          onChanged: (String value) {},
          cursorColor: Colors.deepOrange,
          decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.lock_outline,
                  size: 15,
                  color: Color(0xff020529),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}

class InputMeter extends StatelessWidget {
  const InputMeter({
    Key? key,
    this.meterController,
  }) : super(key: key);

  final TextEditingController? meterController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: meterController,
          keyboardType: TextInputType.number,
          onChanged: (String value) {},
          cursorColor: Colors.deepOrange,
          decoration: const InputDecoration(
              hintText: "Meter Number",
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.point_of_sale_outlined,
                  size: 15,
                  color: Color(0xff020529),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}

class InputNumber extends StatelessWidget {
  const InputNumber({
    Key? key,
    this.numberController,
  }) : super(key: key);

  final TextEditingController? numberController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: numberController,
          keyboardType: TextInputType.number,
          onChanged: (String value) {},
          cursorColor: Colors.deepOrange,
          decoration: const InputDecoration(
              hintText: "Phone Number",
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.phone_outlined,
                  size: 15,
                  color: Color(0xff020529),
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
 static buildTextFormField(text1, controller, hint, type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF505050),
              fontSize: 11.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
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
              hintStyle: const TextStyle(
                  fontSize: 11,
                  color: Color(0Xff969799),
                  fontFamily: "WorkSansLight"),
              filled: true,
              fillColor: const Color(0XFFf5f5f5),
              hintText: hint),
        ),
      ],
    );
  }
}

// class Nav extends StatefulWidget {
//   @override
//   _NavState createState() => _NavState();
// }

// class _NavState extends State<Nav> {
//   nab() {
//   //  Navigator.push(context, MaterialPageRoute(builder: (c) => MyApp()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CircularMenu(
//       alignment: Alignment.bottomRight,
//       toggleButtonColor: Colors.amber,
//       items: [
//         CircularMenuItem(
//             icon: Icons.home,
//             color: Colors.green,
//             onTap: () {
//               nab();
//             }),
//         CircularMenuItem(
//             icon: Icons.search,
//             color: Colors.blue,
//             onTap: () {
//               print('stranger');
             
//             }),
//         CircularMenuItem(
//             icon: Icons.settings,
//             color: Colors.orange,
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (c) => Home()));
//             }),
//         CircularMenuItem(
//             icon: Icons.chat,
//             color: Colors.purple,
//             onTap: () {
//               setState(() {});
//             }),
//         CircularMenuItem(
//             icon: Icons.notifications,
//             color: Colors.brown,
//             onTap: () {
//               setState(() {});
//             })
//       ],
//     );
//   }
// }
