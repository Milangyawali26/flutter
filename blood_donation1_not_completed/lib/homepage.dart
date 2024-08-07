import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("blood donation app"),
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        actions: [
          IconButton(onPressed: (
            
          ) => {}, icon: Icon(Icons.settings)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
