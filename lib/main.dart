import 'package:firebase/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main()
async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Home()));
}
class Home extends StatefulWidget {
  String? id;
  Map? m;

  Home([this.id, this.m]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  String gender = "male";
  String skill="";
  bool temp1 = false, temp2 = false, temp3 = false,temp4 =false,temp5=false;
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (widget.id != null) {
      name.text = widget.m!['name'];
      contact.text = widget.m!['contact'];
      email.text = widget.m!['about']['email'];
      gender = widget.m!['about']['gender'];
      skill=widget.m!['about']['skill'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase"),
        backgroundColor: Colors.red[200],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            color: Colors.grey,
            margin: EdgeInsets.all(7),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Card(
            color: Colors.grey,
            margin: EdgeInsets.all(7),
            child: TextField(
              controller: contact,
              decoration: InputDecoration(
                  labelText: "Enter Contact",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Card(
            color: Colors.grey,
            margin: EdgeInsets.all(7),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Center(
            child: Text(
              "Gender",
              style: TextStyle(fontSize: 25),
            ),
          ),

          Row(
            children: [
              Radio(
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  }),

              Text(
                "Male",
                style: TextStyle(fontSize: 20),
              ),

              Radio(
                  value: "Famale",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  }),

              Text(
                "Famale",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Center(
            child: Text(
              "Skill",
              style: TextStyle(fontSize: 25),
            ),
          ),

          Row(
            children: [
              Checkbox(
                  value: temp1,
                  onChanged: (value) {
                    setState(() {
                      temp1 = value as bool;
                    });
                  }),

              Text(
                "Flutter",
                style: TextStyle(fontSize: 5),
              ),

              Checkbox(
                  value: temp2,
                  onChanged: (value) {
                    setState(() {
                      temp2 = value as bool;
                    });
                  }),

              Text(
                "Android",
                style: TextStyle(fontSize: 5),
              ),

              Checkbox(
                  value: temp3,
                  onChanged: (value) {
                    setState(() {
                      temp3 = value as bool;
                    });
                  }),

              Text(
                "Laravel",style: TextStyle(fontSize: 5),
              ),
              Checkbox(
                  value: temp4,
                  onChanged: (value) {
                    setState(() {
                      temp4 = value as bool;
                    });
                  }),

              Text(
                "Web",style: TextStyle(fontSize: 5),
              ),
              Checkbox(
                  value: temp5,
                  onChanged: (value) {
                    setState(() {
                      temp5 = value as bool;
                    });
                  }),

              Text(
                "Graphic",style: TextStyle(fontSize: 5),
              ),

            ],
          ),
          ElevatedButton(

              onPressed: () async {
                 
                StringBuffer s_b = StringBuffer();
                if(temp1 == true)
                {
                  s_b.write("Flutter");
                }
                if(temp2 == true)
                {
                  if(s_b.length >0)
                  {
                    s_b.write("/");
                  }
                  s_b.write("Android");
                }
                if(temp3 == true)
                {
                  if(s_b.length >0)
                  {
                    s_b.write("/");
                  }
                  s_b.write("Laravel");
                }
                if(temp4 == true)
                {
                  if(s_b.length >0)
                  {
                    s_b.write("/");
                  }
                  s_b.write("Web Design");
                }
                if(temp5 == true)
                {
                  if(s_b.length >0)
                  {
                    s_b.write("/");
                  }
                  s_b.write("Graphic");
                }
                skill = s_b.toString();
                if (widget.id != null) {
                  DatabaseReference ref = FirebaseDatabase.instance
                      .ref("moradiya")
                      .child(widget.id!);

                  await ref.set({
                    "name": "${name.text}",
                    "contact": "${contact.text}",
                    "about": {
                      "email": "${email.text}",
                      "gender":"${gender}",
                      "skill":"${skill}",
                    }
                  });
                } else {
                  DatabaseReference ref =
                  FirebaseDatabase.instance.ref("moradiya").push();

                  await ref.set({
                    "name": "${name.text}",
                    "contact": "${contact.text}",
                    "about": {
                      "email": "${email.text}",
                      "gender":"${gender}",
                      "skill":"${skill}",
                    }
                  });
                }
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(StadiumBorder(
                      side: BorderSide(
                          color: Colors.teal,
                          width: 5,
                          style: BorderStyle.solid))),
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              child: Text("Submit")),


          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          }, style: const ButtonStyle(
              shape: MaterialStatePropertyAll(StadiumBorder(
                  side: BorderSide(
                      color: Colors.teal,
                      width: 5,
                      style: BorderStyle.solid))),
              backgroundColor: MaterialStatePropertyAll(Colors.black)),child: Text("view")),

        ],),
      ),
    );
  }
}
