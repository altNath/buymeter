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
      bottomNavigationBar: BottomAppBar(
          height: 60.0,
          color: const Color.fromARGB(255, 54, 116, 54),
          child: Text('Total: RS ', style: textstyle,),
      ),
    );
  }
}

enum MenuOptions{
  edit,
  delete,
  }

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // Item list to be filled and displayed
  final List<Item> _itemList = [];

  // Object controllers
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final qttCtrl = TextEditingController();

  // List Managing functions
  void _addItem(Item i){
    setState(() {
      _itemList.add(i);
    });
  }

  void _removeItem(int i){
    setState(() {
      _itemList.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _itemList.length,
            itemBuilder:(context, i){
              final item = _itemList[i];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text(item.name),
                  subtitle: Text('${item.quantity} x ${item.price}: ${item.price * item.quantity}'),
                  trailing: PopupMenuButton<MenuOptions>(
                    onSelected: (value) {
                      if (value == MenuOptions.edit){
                        print('WIP');
                      }
                      else if (value == MenuOptions.delete){
                        _removeItem(i);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: MenuOptions.edit, child: Row(children: [Icon(Icons.edit), Text('Edit')],)),
                      PopupMenuItem(value: MenuOptions.delete, child: Row(children: [Icon(Icons.delete), Text('Delete')],)),
                    ],
                    icon: Icon(Icons.more_vert),
                    ),
                ),
              );
            }),
          ),
        NewItemWindow(onAdd: _addItem),
      ],
    );
  }
}


class NewItemWindow extends StatelessWidget {
  final void Function(Item) onAdd;
  NewItemWindow({required this.onAdd});

  // Object controllers
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final qttCtrl = TextEditingController();

  void _funNewItem(BuildContext context){
    showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text('New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField( // ---------- Name field
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Item name',
              ),
            ),
            TextField( // ---------- Price field
              controller: priceCtrl,
              decoration: InputDecoration(
                labelText: 'Unit Price',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField( // ---------- Quantity field
              controller: qttCtrl,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            )
          ],
        ),
        actions: [
          TextButton(onPressed: Navigator.of(context).pop, child: Text('Cancel')), //Cancel new item
          ElevatedButton(onPressed:(){ //Add new item
            final newItem = Item(
              name: nameCtrl.text,
              price: double.tryParse(priceCtrl.text) ?? 0.0,
              quantity: int.tryParse(qttCtrl.text) ?? 0,
            );
            onAdd(newItem);
            Navigator.of(context).pop();
          }, child: Text('Add Item')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed:() => _funNewItem(context),
              child: Icon(Icons.add),
              ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
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