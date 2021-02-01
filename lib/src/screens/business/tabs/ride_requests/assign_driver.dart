import 'package:flutter/material.dart';

class AssignDriver extends StatefulWidget {
  @override
  _AssignDriverState createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";

  List<String> _driver;
  List<String> _filterList;

  @override
  void initState() {
    super.initState();
    _driver = new List<String>();
    _driver = [
      "Barry Legbor",
      "Boma Chigozie",
      "Friday Edet",
      "Paul Lawson",
      "Hamson George",
      "Wilfred Monday",
      "Chike Sunday",
      "Hanger Fred",
      "Benny Richard",
      "Frank Johnson",
      "Ernest Sunday",
      "Harold Gen",
      "Trump Steve",
      "Jude Peter"
    ];
    _driver.sort();
  }

  _AssignDriverState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

//Build our Home widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.black, size: 22),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: new Text("Choose Driver",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
        ),
        body: new Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: new Column(
            children: <Widget>[
              _createSearchView(),
              _firstSearch ? _createListView() : _performSearch()
            ],
          ),
        ),
      ),
    );
  }

  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration:
          BoxDecoration(border: Border.all(width: 0.3, color: Colors.black)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Search your driver",
          hintStyle: new TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              fontSize: 15),
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  //Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _driver.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 0.05,
              child: new ListTile(
                  leading: Container(
                      width: 38.0,
                      height: 38.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://blog.bolt.eu/wp-content/uploads/2020/06/1200x628_Oaksure-Financial-Services-insurance-covers-Bolt-passengers-and-drivers-on-all-rides.jpg")))),
                  title: new Text("${_driver[index]}",
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
                  subtitle: new Text('Online',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.grey[300], size: 20),
                  contentPadding: EdgeInsets.only(left: 15, right: 5)),
            );
          }),
    );
  }

  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < _driver.length; i++) {
      var item = _driver[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 0.05,
              child: new ListTile(
                  leading: Container(
                      width: 38.0,
                      height: 38.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://blog.bolt.eu/wp-content/uploads/2020/06/1200x628_Oaksure-Financial-Services-insurance-covers-Bolt-passengers-and-drivers-on-all-rides.jpg")))),
                  title: new Text("${_filterList[index]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                  subtitle: new Text('Online',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.grey[300], size: 20),
                  contentPadding: EdgeInsets.only(left: 15, right: 5)),
            );
          }),
    );
  }
}
