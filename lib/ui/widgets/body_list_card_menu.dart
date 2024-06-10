import 'package:flutter/material.dart';

Widget bodyListCardItem() {
  return Card(
    elevation: 0,
    color: Colors.white,
    child: ListTile(
      title: Text('There is title'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description will be here"),
          Text(
            "Date: 10-6-24",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text('New'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                backgroundColor: Colors.pinkAccent,
              ),
              ButtonBar(
                children: [
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
