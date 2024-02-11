import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() async {
  final conn = PostgreSQLConnection(
    'localhost',
    5432,
    'postgres',
    username: 'admin',
    password: 'newpassword',
  );
  await conn.open();
  final result = await conn.query('SELECT * FROM customer');
  print(result.toString());
  print("###############################################");
  await conn.close();

  runApp(MyApp(result));
}

class MyApp extends StatelessWidget {
  final List<List<dynamic>> result;

  MyApp(this.result);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PostgreSQL Result'),
        ),
        body: ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(result[index][0].toString()),
              subtitle: Text(result[index][1].toString()),
            );
          },
        ),
      ),
    );
  }
}
