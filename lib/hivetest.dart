import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveTest extends StatelessWidget {
  const HiveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database testing"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buttons(updateFun, "Update"),
          buttons(getFun, "Get"),
          buttons(addFun, "Add"),
        ],
      ),
    );
  }

  Center buttons(Function() onTap, String text) {
    return Center(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amberAccent)),
        onPressed: () async {
          await onTap();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void addFun() async {
    var box = await Hive.openBox<Map<String, List<String>>>("selection");
    var geted = box.get("PLL");
    final data = {
      "T": ['2', 'R U R U R U']
    };
    if (geted == null) await box.put("PLL", data);
    print("Added");
  }

  void updateFun() async {
    var box = await Hive.openBox<Map<String, List<String>>>("selection");
    final data = {
      "U": ['0', 'R URUGNFNMFL'],
      "UA": ['2', 'R URUGNFNMFL'],
      "UB": ['3', 'R URUGNFNMFL'],
      "UC": ['1', 'R URUGNFNMFL'],
    };
    box.put("PLL", data);
    print("Updated");
  }

  void getFun() async {
    final box = await Hive.openBox<Map<String, List<String>>>("selection");
    var geted = box.get("PLL");
    final data = {
      "T": ['2', 'R U R U R U']
    };
    await box.put("PLL", data);
    print(geted ?? "Empty");
  }
}
