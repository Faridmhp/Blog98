import 'dart:convert';
import 'package:blogwithclass/Contact.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:avatar_view/avatar_view.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  Future<List<Contact>> getJson(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString(
        "assets/data/contacts.json");
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Contact.fromJSON(f)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(
            child: Text('Blog',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
      ),
      body: FutureBuilder(
        future: getJson(context),
        builder: (context, data){
          if(data.hasData){
            List<Contact> contacts = data.data;
            return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading:
                                //rectangle avatar
                            AvatarView(
                              radius: 35,
                              borderColor: Colors.grey,
                              avatarType: AvatarType.RECTANGLE,
                              backgroundColor: Colors.red,
                              imagePath:
                              contacts[index].imageurl,
                              placeHolder: Container(
                                child: Icon(Icons.person, size: 50,),
                              ),
                              errorWidget: Container(
                                child: Icon(Icons.error, size: 50,),
                              ),
                            ),
                            title: Text(contacts[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'news',
                              fontSize: 15,
                            ),),
                            subtitle: Text(contacts[index].author,
                              style: TextStyle(
                                fontFamily: 'Rajdhani',
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute(desc: contacts[index].description, image: contacts[index].imageurl,title: contacts[index].title, link: contacts[index].url, author: contacts[index].author)),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(contacts[index].date,
                                  style: TextStyle(
                                    fontFamily: 'Rajdhani',
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              );
          } else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  String desc = "";
  String image = "";
  String title = "";
  String link = "";
  String author = "";
  SecondRoute({Key key, this.desc, this.image, this.title, this.link, this.author}): super(key: key);
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(author,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'news',
            fontSize: 20,
          ),),
        leading: IconButton(
          color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body:Container(
          width: double.infinity,
          // height: 600,
          // the most important part of this example
          child: WebView(
            initialUrl: link,
            // Enable Javascript on WebView
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );

  }
}


