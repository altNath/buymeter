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
                  trailing: Row(children: [
                    IconButton(onPressed:() => _removeItem(i), icon: Icon(Icons.delete)), // Delete Item
                    IconButton(onPressed: () => _funEditItem(context, item), icon: Icon(Icons.edit)),
                  ],),
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
  NewItemWindow({super.key, required this.onAdd});

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

void _funEditItem(BuildContext context, Item i){ // Editing items does not require acces to the list, therefore doesn't need to be inside the widget
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final qttCtrl = TextEditingController();


  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField( // Name Input
            controller: nameCtrl,
            decoration: InputDecoration(
            labelText: 'Item Name',
            hintText: i.name,
            ),
          ),
          SizedBox(height: 10.0,),
          TextField( // Price Input
            controller: priceCtrl,
            decoration: InputDecoration(
            labelText: 'Item Name',
            hintText: i.price.toStringAsFixed(2),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10.0,),
          TextField( // Quantity Input
            controller: qttCtrl,
            decoration: InputDecoration(
            labelText: 'Item Name',
            hintText: i.quantity.toString(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10.0,),
        ],
      ),
      actions: [
        Row(
          children: [
            TextButton(onPressed: Navigator.of(context).pop, child: Text('Cancel')),
            ElevatedButton(onPressed:(){
              if (nameCtrl.text.isNotEmpty){
                i.name = nameCtrl.text;
              }
              if (priceCtrl.text.isNotEmpty){
                final newPrice = double.tryParse(priceCtrl.text);
                if (newPrice != null){
                  i.price = newPrice;
                }
              }
              if (qttCtrl.text.isNotEmpty){
                final newQtt = int.tryParse(qttCtrl.text);
                if (newQtt != null){
                  i.quantity = newQtt;
                }
              }
              Navigator.of(context).pop();
            }, child: Text('Save'))
          ],
        )
      ],
    );
  });
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