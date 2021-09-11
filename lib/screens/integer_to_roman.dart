import 'package:codelabs_task/data/model/data_model.dart';
import 'package:codelabs_task/def/constants.dart';
import 'package:flutter/material.dart';

class IntegerToRoman extends StatefulWidget {
  final String screenTitle;
  IntegerToRoman({required this.screenTitle});
  @override
  _IntegerToRomanState createState() => _IntegerToRomanState();
}

class _IntegerToRomanState extends State<IntegerToRoman> {
  TextEditingController singleValueTextEditController = TextEditingController();
  TextEditingController toValueTextEditController = TextEditingController();
  TextEditingController fromValueTextEditController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // List<RomanNumeral> results = [];
  int userInputNumber = 0;
  numToRoman({required int numInput}) {
    String result = '';

    for (int i = 0; i < values.length; i++) {
      while (numInput >= values[i]) {
        result += romanLiterals[i];
        numInput -= values[i];
      }
    }
    romanNumeralsList.add(RomanNumeral.fromJson({"number": userInputNumber, "roman": result}));
    romanNumeralsList.sort((a, b) => a.number.compareTo(b.number));
  }

  void generateRomans() {
    if (singleValueTextEditController.text.isNotEmpty) {
      setState(() {
        userInputNumber = int.parse(singleValueTextEditController.text);
        if (previousInputs.contains(userInputNumber)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Already added'),
            duration: Duration(seconds: 2),
          ));
        } else {
          previousInputs.add(userInputNumber);
          numToRoman(numInput: userInputNumber);
        }
      });
      singleValueTextEditController.text = '';
    } else if (fromValueTextEditController.text.isNotEmpty && toValueTextEditController.text.isNotEmpty) {
      List<int> alreadyAddedNumbers = [];
      if (int.parse(fromValueTextEditController.text) <= int.parse(toValueTextEditController.text)) {
        for (int i = int.parse(fromValueTextEditController.text); i <= int.parse(toValueTextEditController.text); i++) {
          userInputNumber = i;
          if (previousInputs.contains(userInputNumber)) {
            alreadyAddedNumbers.add(userInputNumber);
          } else {
            previousInputs.add(userInputNumber);
            numToRoman(numInput: userInputNumber);
          }
        }
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$alreadyAddedNumbers already added'),
            duration: Duration(seconds: 3),
          ));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(sInvalidInput),
          duration: Duration(seconds: 3),
        ));
      }

      fromValueTextEditController.text = '';
      toValueTextEditController.text = '';
    }
  }

  void deleteRomans(int numberToDelete) {
    setState(() {
      if (previousInputs.contains(numberToDelete)) {
        previousInputs.remove(numberToDelete);
        for (int i = 0; i < romanNumeralsList.length; i++) {
          if (romanNumeralsList[i].number == numberToDelete) {
            romanNumeralsList.removeAt(i);
          }
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$numberToDelete deleted'),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        child: ListView.builder(
          itemCount: romanNumeralsList.length,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${romanNumeralsList[index].number}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '.   ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '${romanNumeralsList[index].roman}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        builder: (_) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            title: Text('Delete number'),
                            content: Text('Are you sure?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  int numberToDelete = romanNumeralsList[index].number;
                                  deleteRomans(numberToDelete);
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.clear,
                      size: 14,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: true,
            builder: (_) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                title: Text('Enter int value'),
                content: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              fromValueTextEditController.text = '';
                              toValueTextEditController.text = '';
                            },
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            controller: singleValueTextEditController,
                            autovalidateMode: AutovalidateMode.disabled,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 20),
                              filled: true,
                              hintText: 'Enter an integer',
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (RegExp(r"^[1-9][0-9]*$").hasMatch(value)) {
                                  return null;
                                } else {
                                  return sInvalidInput;
                                }
                              }

                              return null;
                            },
                          ),
                          Text('OR'),
                          Text('Enter range'),
                          TextFormField(
                            onChanged: (value) {
                              singleValueTextEditController.text = '';
                            },
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            controller: fromValueTextEditController,
                            autovalidateMode: AutovalidateMode.disabled,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 20),
                              filled: true,
                              hintText: 'From',
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (RegExp(r"^[1-9][0-9]*$").hasMatch(value)) {
                                  return null;
                                } else {
                                  return sInvalidInput;
                                }
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            onChanged: (value) {
                              singleValueTextEditController.text = '';
                            },
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            controller: toValueTextEditController,
                            autovalidateMode: AutovalidateMode.disabled,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(right: 20),
                              filled: true,
                              hintText: 'To',
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (RegExp(r"^[1-9][0-9]*$").hasMatch(value)) {
                                  return null;
                                } else {
                                  return sInvalidInput;
                                }
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        generateRomans();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Ok'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
