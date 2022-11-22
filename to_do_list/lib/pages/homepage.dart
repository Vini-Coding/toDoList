import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Add a Task",
                    hintText: "Ex. Study Flutter",
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.add, size: 30,),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff00d7f3),
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
