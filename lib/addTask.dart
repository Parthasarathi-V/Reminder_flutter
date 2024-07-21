import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/home_page.dart';
import 'package:reminder/model/task.dart';
import 'package:reminder/search_page.dart';
import 'package:reminder/serivice/task_service.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();

}
class _AddTaskState extends State<AddTask> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _titleInput = TextEditingController();
  final TextEditingController _subtitleInput = TextEditingController();
  late String _importanceInput = "";

  bool _validataTask = false;
  bool _validataSubtitle = false;
  bool _validataDate = false;
  final _taskServices = TaskService();
  bool mst = false;
  bool imp = false;
  bool nim = false;

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    late double dspSize;
    if(hgt <= 400.00){
      dspSize = hgt*2;
    }
    else{
      dspSize = (hgt/1)-180;
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.teal[800],
            appBar: AppBar(
              toolbarHeight: hgt / 10,
              title: const Text(
                "Add Task", style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.teal[800],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                  });
                },),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: dspSize,
                width: wdh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: hgt / 500,),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Title ", style: TextStyle(fontSize: 18),),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                                cursorColor: Colors.teal,
                                controller: _titleInput,
                                decoration: InputDecoration(
                                  labelText: "Title",
                                  hintText: 'add the title',
                                  fillColor: Colors.teal,
                                  labelStyle: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  hoverColor: Colors.black,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  errorText: _validataTask
                                      ? 'Title Value Can\'t Be Empty'
                                      : null,
                                )
                            ),
                          ),
                          const Text(
                            "Description ", style: TextStyle(fontSize: 18),),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                                controller: _subtitleInput,
                                decoration: InputDecoration(
                                  labelText: "Subtitle",
                                  hintText: 'add the subtitle',
                                  labelStyle: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  errorText: _validataSubtitle
                                      ? 'subtitle Value Can\'t Be Empty'
                                      : null,
                                )
                            ),
                          ),
                          const Text(
                            "Date & Time", style: TextStyle(fontSize: 18),),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                                controller: _dateInput,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025)
                                  );
                                  if (pickedDate != null) {
                                    String modifiedDate = DateFormat(
                                        "d MMM yyyy").format(pickedDate);
                                    setState(() {
                                      _dateInput.text = modifiedDate.toString();
                                    });
                                  }
                                  else {
                                    print("not selected");
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  hintText: 'select the date',
                                  labelStyle: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),),
                                  errorText: _validataDate
                                      ? 'Date Value Can\'t Be Empty'
                                      : null,
                                )
                            ),
                          ),
                          const Text(
                            "Importance ", style: TextStyle(fontSize: 18),),
                          Row(
                            children: [
                              Checkbox(value: mst, onChanged: (val){
                                setState(() {
                                  mst = val!;
                                  if(mst == true){
                                    _importanceInput = "Must";
                                    nim = false;
                                    imp = false;
                                  }
                                });
                              }),
                              SizedBox(width: 5,),
                              Text("Must work",style: TextStyle(fontSize: 13),)
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: imp, onChanged: (val){
                                setState(() {
                                  imp = val!;
                                  if(imp == true){
                                    _importanceInput = "Important";
                                    mst = false;
                                    nim = false;
                                  }
                                });
                              }),
                              const SizedBox(width: 5,),
                              const Text("Important Work",style: TextStyle(fontSize: 13),)
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: nim, onChanged: (val){
                                setState(() {
                                  nim = val!;
                                  if(nim == true){
                                    _importanceInput = "Work";
                                    mst = false;
                                    imp = false;
                                  }
                                });
                              }),
                              const SizedBox(width: 5,),
                              const Text("Normal Work",style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: () {
                          _titleInput.text = '';
                          _subtitleInput.text = '';
                          _dateInput.text = '';
                        },
                          child: const Text("clear", style: TextStyle(
                              color: Colors.white, fontSize: 17),),
                          color: Colors.red[800],
                        ),
                        SizedBox(width: 20,),
                        MaterialButton(onPressed: () async {
                          setState(() {
                            _titleInput.text.isEmpty
                                ? _validataTask = true
                                : _validataTask = false;
                            _subtitleInput.text.isEmpty ?
                            _validataSubtitle = true : _validataSubtitle =
                            false;
                            _dateInput.text.isEmpty
                                ? _validataDate = true
                                : _validataDate = false;
                          });

                          if (_validataTask == false &&
                              _validataSubtitle == false &&
                              _validataDate == false) {
                            var _task = Task();
                            _task.title = _titleInput.text;
                            _task.subtitle = _subtitleInput.text;
                            _task.date = _dateInput.text;
                            _task.importance = _importanceInput;
                            var result = await _taskServices.SaveTask(_task);
                            Navigator.pop(context, result);
                          }
                        },
                          color: Colors.teal[800],
                          child: const Text("add", style: TextStyle(
                              color: Colors.white, fontSize: 17),),)
                      ],
                    )
                  ],
                ),
              ),
            ),

            bottomNavigationBar: BottomNav()
        )
    );
  }
}

class BottomNav extends StatefulWidget {
  late num index = 0;
  //BottomNav({required this.index);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.teal.shade800,
      elevation: 30,
      unselectedItemColor: Colors.white60,
      currentIndex: 1,
      iconSize: 32,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_outlined),label: "Add"),
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: "Search"),
      ],
      onTap: (index) {
        if (index == 0) {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
          });
        }
        else if(index == 1)
        {
          AddTask();
        }
        else
        {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
          });
        }
      },
    );
  }
}

