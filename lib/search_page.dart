import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'addTask.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        appBar: AppBar(
          toolbarHeight: hgt / 10,
          title: const Text(
            "Search", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.teal[800],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
              });
            },),
        ),
        backgroundColor: Colors.teal[800],
        body: Container(
          height: dspSize,
          width: wdh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                const OwnSearch(),
                Divider(
                  thickness: 5,
                  color: Colors.teal[800],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: dspSize/50, horizontal: wdh/38),
                  child: Tasks(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}

class OwnSearch extends StatefulWidget {
  const OwnSearch({super.key});
  @override
  State<OwnSearch> createState() => _OwnSearchState();
}
class _OwnSearchState extends State<OwnSearch> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdh = MediaQuery.of(context).size.width;
    return Container(
      height: hgt/10,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
       // color: Colors.grey,
      ),
      child: Center(
        child: TextField(
            controller: dateController,
            onTap:() async{
              DateTime? pickedDate =  await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025)
              );
              if(pickedDate != null)
              {
                String modifiedDate = DateFormat("d MMM yyyy").format(pickedDate);
                setState(() {
                  dateController.text = modifiedDate.toString();
                });
              }
              else
              {
                print("not selected");
              }
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
                hintText: "Choose Date",
                labelStyle: TextStyle(fontSize: 15, color: Colors.teal[900]),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(20),)
            )
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
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.teal.shade800,
      elevation: 30,
      unselectedItemColor: Colors.white60,
      currentIndex: 2,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
          });
        }
        else if(index == 1)
        {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
          });
        }
        else
        {
          SearchPage();
        }
      },
    );
  }
}


