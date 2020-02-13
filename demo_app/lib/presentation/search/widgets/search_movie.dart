import 'package:flutter/material.dart';

class SearchMovie extends StatelessWidget {

  final Function _filterKeyWord;

  SearchMovie(this._filterKeyWord);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [
                     Colors.orange[100],//Color(0xFFFFFFEE),
                     Colors.orange
                  ], // whitish to gray
                  tileMode: TileMode.repeated,
                ), // repeats th
            // color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          labelText: "Title"),
                      style: Theme.of(context).textTheme.body1,
                      onChanged: (value){
                        _filterKeyWord(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          labelText: "Year"),
                      style: Theme.of(context).textTheme.body1,
                      onChanged: (value){
                        
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
            ),
          )),
    );
  }
}
