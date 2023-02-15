import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/global_list.dart';

class DraggablePage extends StatefulWidget {
  const DraggablePage({Key? key}) : super(key: key);

  @override
  State<DraggablePage> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List.generate(fruitsImages.length, (index) => fruitsImages[index].isCorrect = false);
    List.generate(fruitsName.length, (index) => fruitsName[index].isCorrect = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag And Drop"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              List.generate(fruitsImages.length, (index) => fruitsImages[index].isCorrect = false);
              List.generate(fruitsName.length, (index) => fruitsName[index].isCorrect = false);
              setState(() {});
            },
            icon: const Icon(
              Icons.restart_alt,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue.shade50),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              const Text("Let's Play Game!!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: fruitsImages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: Row(
                            children: [
                              (fruitsImages[index].isCorrect == false)
                                  ? Draggable(
                                      data: fruitsImages[index].name,
                                      feedback: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          fruitsImages[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      childWhenDragging: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          fruitsImages[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      onDragCompleted: () {
                                        setState(() {
                                          fruitsImages[index].isCorrect = true;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Yeah, you done very well!!"),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          width: 300,
                                        ));
                                      },
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          fruitsImages[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      color: fruitsImages[index].color.withOpacity(0.4),
                                      child: Center(
                                        child: Text("Yeh!!",
                                            style: TextStyle(fontSize: 25, color: fruitsImages[index].color, fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                              const Spacer(),
                              DragTarget(
                                onWillAccept: (data) => data == fruitsName[index].name,
                                onAccept: (val) {
                                  setState(() {
                                    fruitsName[index].isCorrect = true;
                                  });
                                },
                                builder: (context, candidateData, rejectedData) {
                                  return (fruitsName[index].isCorrect == false)
                                      ? DottedBorder(
                                          dashPattern: const [9, 6, 6, 6],
                                          color: Colors.black,
                                          strokeWidth: 3,
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: fruitsName[index].color.withOpacity(0.3),
                                            ),
                                            child: Center(
                                              child: Text(
                                                fruitsName[index].name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: fruitsName[index].color, fontSize: 20, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )
                                      : DottedBorder(
                                          dashPattern: const [9, 6, 6, 6],
                                          color: Colors.black,
                                          strokeWidth: 3,
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: fruitsName[index].color.withOpacity(0.3),
                                            ),
                                            child: Image.asset(fruitsName[index].image, fit: BoxFit.fill),
                                          ),
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
