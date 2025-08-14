import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(
                    value: 'e1',
                    child: Text('element1')
                  ),
                  DropdownMenuItem(
                    value: 'e2',
                    child: Text('element2')
                  ),
                  DropdownMenuItem(
                    value: 'e3',
                    child: Text('element3')
                  ),
                ], 
                onChanged: (String? value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
        
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
                onEditingComplete: () => setState(() {}), // arrow function allow one functionality
              ),
              Text(controller.text),
        
              Checkbox(
                tristate: true,
                value: isChecked, 
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              CheckboxListTile.adaptive(
                tristate: true, // can have three values
                title:Text('Click Me'),
                value: isChecked, 
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
        
              Switch(
                value: isSwitched, 
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title:Text('Switch Me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
        
              Slider(
                max: 10.0,
                value: sliderValue, 
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                  print(value);
                },
              ),
        
              GestureDetector(
                onTap: () {
                  print('image selected');
                },
                child: Image.asset('assets/images/smile.png')
              ),
              InkWell(
                splashColor: Colors.teal,
                onTap: () {
                  print('image selected');
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),

              ElevatedButton( // snack bar
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Snackbar'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }, 
                child: Text('Open Snack Bar'),
              ),
              Divider( // line diveider, also has VerticalDivider
                color: Colors.blue,
                thickness: 2.0,
                endIndent: 10.0,
              ),
              ElevatedButton( // Alert
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Alert Title'),
                        content: Text('Alert Content'),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: Text('Close')
                          ),
                        ],
                      );
                    },

                  );
                }, 
                child: Text('Open Dialog'),
              ),
              FilledButton(
                onPressed: () {
                
                },
                child: Text('click me'),
              ),
              TextButton(
                onPressed: () {
                
                },
                child: Text('click me'),
              ),
              OutlinedButton(
                onPressed: () {
                
                },
                child: Text('click me'),
              ),
              CloseButton(),
              BackButton(),

            ],
          ),
        ),
      ),
    );
  }
}