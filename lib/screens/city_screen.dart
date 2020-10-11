import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ManageCity extends StatefulWidget {
  @override
  _ManageCityState createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {
  List _city = ["A", "B", "C", "D"];
  bool _isSearching = false;
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(),
          Container(
            margin: EdgeInsets.only(
              top: 40,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * .04, right: size.width * .08),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  //color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _globalKey.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.short_text,
                          size: 40,
                        ),
                      ),
                      Text(
                        "Manage City",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                          child: Icon(Icons.add, size: 30))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                top: 20,
              ),
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {},
                    children: _city.map((x) {
                      return Container(
                        key: ValueKey(x),
                        //height: size.aspectRatio*200,
                        //color: Colors.black45,
                        child: Card(
                          shadowColor: Color(0xff536DFE),
                          elevation: 6,
                          child: ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text("London"),
                            subtitle: Text("United Kingdom"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: () {}),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ))
              ],
            ),
          ),
          _isSearching ? _search() : Container(),
        ],
      ),
    );
  }

  Widget _search() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 10),
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          /* autoCompleteSearch(value);
                        } else {
                          if (predictions.length > 0 && mounted) {
                            setState(() {
                              predictions = [];
                            });*/
                        }
                      }),
                ),
                IconButton(
                    icon: Icon(Icons.close, size: 35),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                    })
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('London'),
                      subtitle: Text("United Kingdom"),
                      trailing:
                          IconButton(icon: Icon(Icons.add), onPressed: () {}),
                    );
                  }))
        ],
      ),
    );
  }
}
