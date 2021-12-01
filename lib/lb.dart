import 'package:flutter/material.dart';
//数据源
final Set<Person> sets = new Set<Person>();


class ListViewWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewState();
  }
}

class ListViewState extends State<ListViewWidget> {

  List<ItemWidget> list = <ItemWidget>[];

  add() {
    print('回调了add()');
    setState(() {
      sets.add(new Person('战士 ${sets.length + 1}', '我是第${sets.length + 1}个兵'));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('列表示例'),
        centerTitle: true,
      ),
      body: new ListView(
        children: sets.map((p) {
          return new ItemWidget(p);
        }).toList(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: add,
//        onPressed: null,
        tooltip: 'add',
        child: new Icon(Icons.add),
        backgroundColor: Colors.blue[400],
      ),
    );
  }
}
//数据实体
class Person {
  String name;
  String info;

  Person(this.name, this.info);
}
//liveview子项
class ItemWidget extends StatelessWidget {
  final Person _person;

  ItemWidget(this._person);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(_person.name[0]),
        backgroundColor: Colors.blue[400],
      ),
      title: new Text(_person.name),
      subtitle: new Text(_person.info),
    );
  }
}