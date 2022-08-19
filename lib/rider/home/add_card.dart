import 'package:cabby/driver/widget/shared/components/dialog_builder.dart';
import 'package:cabby/rider/Models2/usercard_model.dart';
import 'package:flutter/material.dart';
import 'package:cabby/rider/config/config.dart';

class AddCard extends StatefulWidget {
  final String? userId, token;

  const AddCard({Key? key, this.userId, this.token}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  var currentSelectedValueThree;
  final List<String> typeOfRide = ["Debit Card", "Credit Card"];

  double systemHeight = 0;

  double systemWidth = 0;
  final _formKey = GlobalKey<FormState>();
  CardModel _formData =
      CardModel(user_id: '', card_number: '', expirity_date: '', cvv: "");

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // print("validated");
      // _formData.user_id = widget.userId!;
      // print(_formData.expirity_date);
      // print(_formData.user_id);
      // print(_formData.card_number);
      // print(_formData.cvv);
      // return;
      DialogBuilderMode(context).showLoadingIndicator('adding Card ....');

      // add(_formData, widget.token!);
    } else {}
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    systemHeight = MediaQuery.of(context).size.height;
    systemWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(context),
                    topIconRight(
                      
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Add New Card',
                  style: kOnboardTitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: systemWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Payment Method ',
                        style: k14400Faint,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              // itemHeight: 50,
                              iconEnabledColor: Colors.white,
                              hint: const Text(
                                'Debit Card',
                                style: k16400Faint,
                              ),
                              // menuMaxHeight: systemHeight / 2,
                              // isDense: true,
                              // isExpanded: true,
                              dropdownColor: primaryColor,
                              style: const TextStyle(
                                  fontFamily: 'JosefinSans-Regular',
                                  color: Colors.white,
                                  fontSize: 18),
                              underline: Container(),
                              // value: _dropdownValues.first,
                              value: currentSelectedValueThree,
                              items: typeOfRide
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),

                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValueThree =
                                      newValue.toString();
                                  print(currentSelectedValueThree);
                                });
                                // print(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width / 1.1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(' Card Number   '),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        // hintText: title,
                                        fillColor: greyFaintColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          // _displayWarningMotionToast(context,
                                          //     title: "aaaaaa",
                                          //     titleBody: "bbb");
                                          // print("empty ");
                                          return "Enter card number";
                                          // return;
                                        } else {
                                          setState(() {
                                            _formData.card_number = value;
                                          });
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width / 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(' Expiry Date   '),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            // hintText: title,
                                            fillColor: greyFaintColor,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 3,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              // _displayWarningMotionToast(context,
                                              //     title: "aaaaaa",
                                              //     titleBody: "bbb");
                                              // print("empty ");
                                              return "Enter card expiry date";
                                              // return;
                                            } else {
                                              setState(() {
                                                _formData.expirity_date =
                                                    value;
                                              });
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(' CVV   '),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            // hintText: title,

                                            fillColor: greyFaintColor,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 3,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          onSaved: (value) =>
                                              _formData.cvv = value!,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              // _displayWarningMotionToast(context,
                                              //     title: "aaaaaa",
                                              //     titleBody: "bbb");
                                              // print("empty ");
                                              return "Enter card cvv";
                                              // return;
                                            } else {
                                              setState(() {
                                                _formData.cvv = value;
                                              });
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              child: userTypeButton(
                                  "Add", primaryColor, "dark", context),
                              onTap: () {
                                validator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    ));
  }
}
