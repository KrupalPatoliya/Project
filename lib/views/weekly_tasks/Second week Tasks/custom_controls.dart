import 'package:flutter/material.dart';

class CustomControlsPage extends StatefulWidget {
  const CustomControlsPage({Key? key}) : super(key: key);

  @override
  State<CustomControlsPage> createState() => _CustomControlsPageState();
}

class _CustomControlsPageState extends State<CustomControlsPage> {
  String? gender = "Male";
  bool checkedBox = true;
  bool checkedBox1 = false;
  bool checkedBox2 = false;
  bool isSwitch = false;
  bool customRadio = true;
  bool customRadio1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("layouts/controls"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Custom Buttons",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 4,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        customRadio = !customRadio;
                        customRadio1 = !customRadio1;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: (customRadio)
                              ? Border.all(
                                  width: 3,
                                  color: Colors.blue.shade800,
                                )
                              : Border.all(
                                  width: 3,
                                  color: Colors.white,
                                )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "BASIC",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: (customRadio) ? Colors.blue : Colors.white,
                                  shape: BoxShape.circle,
                                  border: (customRadio)
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.blue,
                                          strokeAlign: BorderSide.strokeAlignCenter,
                                          style: BorderStyle.none,
                                        )
                                      : Border.all(
                                          width: 3,
                                          color: Colors.white,
                                          strokeAlign: BorderSide.strokeAlignCenter,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "\$ 59.00",
                            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        customRadio1 = !customRadio1;
                        customRadio = !customRadio;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: (customRadio1)
                              ? Border.all(
                                  width: 3,
                                  color: Colors.blue.shade800,
                                )
                              : Border.all(
                                  width: 3,
                                  color: Colors.white,
                                )),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Standard",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: (customRadio1) ? Colors.blue : Colors.white,
                                  shape: BoxShape.circle,
                                  border: (customRadio1)
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.blue,
                                          strokeAlign: BorderSide.strokeAlignCenter,
                                          style: BorderStyle.none,
                                        )
                                      : Border.all(
                                          width: 3,
                                          color: Colors.white,
                                          strokeAlign: BorderSide.strokeAlignCenter,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "\$ 199.00",
                            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 4,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "CheckBox Button",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkedBox = !checkedBox;
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: (checkedBox)
                            ? Border.all(
                                width: 3,
                                color: Colors.redAccent.shade700,
                              )
                            : Border.all(
                                width: 3,
                                color: Colors.blue,
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "R",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (checkedBox) ? Colors.red : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Reading",
                            style: TextStyle(
                              fontSize: 15,
                              color: (checkedBox) ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkedBox1 = !checkedBox1;
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: (checkedBox1)
                            ? Border.all(
                                width: 3,
                                color: Colors.redAccent,
                              )
                            : Border.all(
                                width: 3,
                                color: Colors.blue,
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "W",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (checkedBox1) ? Colors.red : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Walking",
                            style: TextStyle(
                              fontSize: 15,
                              color: (checkedBox1) ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkedBox2 = !checkedBox2;
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: (checkedBox2)
                            ? Border.all(
                                width: 3,
                                color: Colors.redAccent,
                              )
                            : Border.all(
                                width: 3,
                                color: Colors.blue,
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "W",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (checkedBox2) ? Colors.red : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Writing",
                            style: TextStyle(
                              fontSize: 15,
                              color: (checkedBox2) ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 4,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Radio Button",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Male", style: TextStyle(color: Colors.white, fontSize: 18)),
                leading: Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text("Female", style: TextStyle(color: Colors.white, fontSize: 18)),
                leading: Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text("Others", style: TextStyle(color: Colors.white, fontSize: 18)),
                leading: Radio(
                  value: "Others",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Checked Box",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Reading",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                leading: Checkbox(
                  value: checkedBox,
                  onChanged: (value) {
                    setState(
                      () {
                        checkedBox = value!;
                      },
                    );
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "Walking",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                leading: Checkbox(
                  value: checkedBox1,
                  onChanged: (value) {
                    setState(
                      () {
                        checkedBox1 = value!;
                      },
                    );
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "writing",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                leading: Checkbox(
                  value: checkedBox2,
                  onChanged: (value) {
                    setState(
                      () {
                        checkedBox2 = value!;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Switch",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              SwitchListTile(
                  title: const Text(
                    "Switch",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  value: isSwitch,
                  onChanged: (val) {
                    setState(() {
                      isSwitch = val;
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Radio Button",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
                title: const Text(
                  "Male",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
              RadioListTile(
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
                title: const Text(
                  "Female",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
              RadioListTile(
                value: "Others",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
                title: const Text(
                  "Others",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Checked Box",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 3,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                title: const Text(
                  "Reading",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                value: checkedBox,
                onChanged: (value) {
                  setState(
                    () {
                      checkedBox = value!;
                    },
                  );
                },
              ),
              CheckboxListTile(
                title: const Text(
                  "Walking",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                value: checkedBox1,
                onChanged: (value) {
                  setState(
                    () {
                      checkedBox1 = value!;
                    },
                  );
                },
              ),
              CheckboxListTile(
                title: const Text(
                  "Writing",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                value: checkedBox2,
                onChanged: (value) {
                  setState(
                    () {
                      checkedBox2 = value!;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
