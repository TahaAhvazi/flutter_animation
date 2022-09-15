import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int myNumber = 0;
  late AnimationController _controller;
  late final Animation<AlignmentGeometry> alignmentGeometry;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    alignmentGeometry = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height - 200,
            width: width,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() {
                    myNumber = index;
                    print("$index");
                  }),
                  onDoubleTap: () => setState(() {
                    myNumber == index;
                  }),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    padding: EdgeInsets.all(myNumber == index ? 8 : 15),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color:
                            index == myNumber ? Colors.blueAccent : Colors.pink,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color.fromARGB(255, 53, 53, 53),
                            width: .2),
                      ),
                      height: myNumber == index
                          ? height * 15 / 100
                          : height * 5 / 100,
                      width: width,
                      duration: const Duration(milliseconds: 300),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: myNumber == index ? 20 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                          duration: const Duration(milliseconds: 250),
                          child: Text("I am Container number ${index + 1} !"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AlignTransition(
            alignment: alignmentGeometry,
            child: RotationTransition(
              turns: _rotateAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 4, 202, 252),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                height: 100,
                width: 100,
                child: const Center(
                  child: Text(
                    "Taha.codes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
