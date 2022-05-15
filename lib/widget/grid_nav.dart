import 'package:flutter/material.dart';
import 'package:mock_ctrip/model/grid_nav_model.dart';

class GridNav extends StatefulWidget {
  final GridNavModel? gridNavModel;

  const GridNav({Key? key, required this.gridNavModel}) : super(key: key);

  @override
  _GridNavState createState() => _GridNavState();

  // @override
  // Widget build(BuildContext context) {
  //   throw Text('GridNav');
  // }
}

class _GridNavState extends State<GridNav>{
  @override
  Widget build(BuildContext context) {
    throw Text('GridNav');
  }

}