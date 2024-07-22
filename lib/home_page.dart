import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/editTask.dart';
import 'package:reminder/search_page.dart';
import 'package:reminder/serivice/task_service.dart';
import 'addTask.dart';
import 'model/task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal[800],
      body: SingleChildScrollView(
        child: SafeArea(
          child :Column(
            children: [
              Container(
                height: hgt/4.5,
                width: wdh,
                decoration: BoxDecoration(
                  color: Colors.teal[800],
                ),
                child:Center(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const TopRow(),
                        TopDate()
                      ]
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  height: hgt,
                  width: wdh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Tasks(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

class Tasks extends StatefulWidget {

  var title;
  var subtitle;
  var date;
  var importance;
  var id;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  late List<Tasks> _taskList;
  final _taskSerivice = TaskService();

  getAllTasks() async{
    var tasks = await _taskSerivice.readAllTasks();
    tasks.forEach((tasks){
      setState(() {
        var taskModule = Tasks();
        taskModule.id = tasks['id'];
        taskModule.title = tasks['title'];
        taskModule.subtitle = tasks['subtitle'];
        taskModule.date = tasks['date'];
        taskModule.importance = tasks['importance'];
        _taskList.add(taskModule);
      });
    });
  }

  @override

  void initState(){
    getAllTasks();
    super.initState();
    _taskList=[];
  }

  completeBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }

  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: hgt/70,
          ),
          const Text(
              "13:00 AM",
              style: TextStyle(
                fontSize: 20,
              )
          ),
          Container(
            height: hgt/200,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
          ),
          SizedBox(height: hgt/70,),
          for(int i = 0; i < _taskList.length; i++)
            TaskCards(titleIn: _taskList[i].title ?? '',
              subtitleIn: _taskList[i].subtitle ?? '',
              importance: _taskList[i].importance ?? 'null',
              date: _taskList[i].date ?? '',
              ),

    ]
    );
  }
}

class TaskCards extends StatelessWidget {

  TaskCards({super.key, required this.titleIn, required this.subtitleIn, required this.importance, required this.date});
  String titleIn = "";
  String subtitleIn = "";
  String importance = "";
  String date = "";

  Future showTask(BuildContext context, String title, String description, String importance, Color clr) async {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    print(importance);
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Text(title),
                  const SizedBox(width: 10,),
                  Text("01:00 AM \n $date ", style: const TextStyle(fontSize: 10,color: Colors.black54),),
                  SizedBox(width: wdh/15,),
                  Icon(Icons.tag_outlined,color: clr,size: 10,),
                  Text(importance, style: TextStyle(fontSize: 10,color: clr),),
                ],
              ),
              content: Text(description),
              actions: [
                TextButton(onPressed: (){}, child: const Text("Edit")),
                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Ok")),
              ],
            );
          }
      );
  }
  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    Color clr ;
    if(importance == "Must"){
      clr = Colors.red;
    }
    else if(importance == "Important"){
      clr = Colors.green;
    }
    else if(importance == "Work"){
      clr = Colors.grey;
    }
    else{
      clr = Colors.white;
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: hgt/200,
            width: wdh/15,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          SizedBox(width: wdh/40,),
          Card(
              color: Colors.white,
              elevation: 20.0,
              shadowColor: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              child: Container(
                width: wdh/1.2,
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        showTask(context, titleIn, subtitleIn, importance, clr);
                      },
                      child: SizedBox(
                        width: wdh/1.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  titleIn,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                const SizedBox(width: 30,),
                                Icon(Icons.tag_outlined,color: clr,),
                                Center(
                                  child: Text(
                                    importance,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      color: clr,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              subtitleIn,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        var _taskList;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTask(task: _taskList,)));
                      }, 
                      icon: const Icon(Icons.edit_note_outlined,size: 30, ),),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline_outlined,size: 30,))
                  ],
                ),
              )
          )
        ],
      );
  }
}

class TopRow extends StatefulWidget {
  const TopRow({super.key});

  @override
  State<TopRow> createState() => _TopRowState();
}

class _TopRowState extends State<TopRow> {
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

    return Container(
      padding: const EdgeInsets.all(10),
      height: (hgt/4.5)-20,
      width: (wdh/1.5)-10,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Daily",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 15.0),
              Text("meetings",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                ),
              ),

            ],
          ),
          SizedBox(height: 10,),
          Text("Today Task's",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ]
      ),
    );
  }
}

class TopDate extends StatelessWidget {

  //DateTime now = DateTime.now();
  final String _day = DateFormat('EEE').format(DateTime.now());
  final String _date = DateFormat('d').format(DateTime.now());
  final String _month = DateFormat('MMM  yyyy').format(DateTime.now());

  TopDate({super.key});

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    return SizedBox(
      height: (hgt/4.5)-20,
      width: (wdh/3)-20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_date,style:const TextStyle(fontSize : 40, color: Colors.white),),
            Text(_day,style:const TextStyle(fontSize : 25, color: Colors.white),),
            Text(_month,style:const TextStyle(fontSize : 20, color: Colors.white),)
          ],
        ),
      ),
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
  late List<Tasks> _taskList;
  final _taskSerivice = TaskService();

  getAllTasks() async{
  var tasks = await _taskSerivice.readAllTasks();
  tasks.forEach((tasks){
    setState(() {
      var taskModule = Tasks();
      taskModule.id = tasks['id'];
      taskModule.title = tasks['title'];
      taskModule.subtitle = tasks['subtitle'];
      taskModule.date = tasks['date'];
      taskModule.importance = tasks['importance'];
      _taskList.add(taskModule);
    });
  });
}
  void initState(){
    getAllTasks();
    super.initState();
    _taskList=[];
  }

  completeBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.teal.shade800,
      elevation: 30,
      unselectedItemColor: Colors.white60,
      currentIndex: 0,
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
          HomeView();
        }
        else if(index == 1)
        {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask())).then((data) {
              if (data != null){
                getAllTasks();
                completeBar("The Task is added Successfully");
              }
            });
          });
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
