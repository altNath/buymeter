import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const TextStyle textstyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 116, 54),
        title: const Text('Buymeter'),
        titleTextStyle: textstyle,
        centerTitle: true,
        actions: [
          IconButton(onPressed:() => print('WIP'), icon: const Icon(Icons.menu, color: Colors.white,)),
          ],
      ),
      body: ItemList(),
      floatingActionButton: FloatingActionButton(onPressed:() => NewItemWindow(), child: Icon(Icons.add),),
      bottomNavigationBar: BottomAppBar(
          height: 60.0,
          color: const Color.fromARGB(255, 54, 116, 54),
          child: Text('Total: RS ', style: textstyle,),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  //Item list to be filled and displayed
  final List<Item> _itemList = [];

  // Object controllers
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final qttCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _itemList.length,
      itemBuilder:(context, i){
        Card();
      });
  }
}


class NewItemWindow extends StatelessWidget {
  const NewItemWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class Item{
  String name;
  double price;
  int quantity;

  Item({
    required this.name,
    required this.price,
    required this.quantity,
  });
}