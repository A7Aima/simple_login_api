import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DisplayScreen extends StatefulWidget {
  final String token;

  const DisplayScreen({Key key, this.token}) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  List<dynamic> data = [];
  //Map<String,dynamic>
  @override
  void initState() {
    getHttp(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data[i]['avatar'],
                    ),
                  ),
                  title: Text(
                      '${data[i]['first_name'] + ' ' + data[i]['last_name']}'),
                  subtitle: Text('${data[i]['email']}'),
                  trailing: Text("Id: " + data[i]['id'].toString()),
                );
              },
            ),
    );
  }

  void getHttp(String token) async {
    try {
      bool loop = true;
      int pageNo = 1;
      while (loop) {
        Response response = await Dio().get(
          "https://reqres.in/api/users?page=$pageNo",
          options: Options(
            headers: {
              "authorization": token,
            },
          ),
        );
        print(response.data['data']);
        List<dynamic> resp = response.data['data'];
        print(resp.isNotEmpty);
        if (resp.isNotEmpty) {
          for (dynamic i in resp) {
            setState(() {
              //print(i.runtimeType);
              data.add(i);
            });
          }
          pageNo += 1;
        } else {
          loop = false;
        }
        //print(data.isEmpty);
      }

      return;
    } catch (e) {
      print(e);
    }
  }
}
