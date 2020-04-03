import 'package:flutter/material.dart';
import 'package:todoapp/models/databasehelper.dart';
import 'package:todoapp/models/todoitem.dart';
import 'package:todoapp/ui/date.dart';


class NotoDoScreen extends StatefulWidget {
  NotoDoScreen({Key key}) : super(key: key);

  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}

class _NotoDoScreenState extends State<NotoDoScreen> {
 final TextEditingController _textEditingController = TextEditingController();
List<NoDoItem> _itemlist = <NoDoItem>[];
  @override
  void initState() {
   
    super.initState();
    readTodolist();
  }

 

  var my = DatabaseHelper();

  void handleSubmit(String text) async {

                  _textEditingController.clear();

                NoDoItem notes =   NoDoItem(text, DateTime.now().toIso8601String());

                var saved = await my.saveUser(notes);

                var check = await my.getUser(saved);
                
                setState(() {
                  
                  _itemlist.insert(0,check);
                });

      
                  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,

      body: Column(

        children: <Widget>[

          Flexible(child: ListView.builder(padding: EdgeInsets.all(8.0),
          reverse: false,itemBuilder:(_,int index){




            return Card(

              child: ListTile(

                title:_itemlist[index],
                onLongPress: ()=>handleupdate(_itemlist[index],index),
                                trailing: Listener(
                
                                  key: Key(_itemlist[index].itemName),
                                  child: Icon(Icons.remove_circle,color: Colors.redAccent,),
                                  onPointerDown: (pointerEvent)=> deleteitem(_itemlist[index].id,index),
                                  
                                  
                                ),
                
                              ),
                
                
                            );
                          } ,itemCount: _itemlist.length,))
                        ],
                
                
                
                      ),
                      floatingActionButton: FloatingActionButton(onPressed: _showFormDialog,tooltip: "Add items",backgroundColor: Colors.redAccent,child: ListTile(title:Icon(Icons.add),),),
                          );
                      
                        }
                      
                      
                        void _showFormDialog() {
                
                          var alert = AlertDialog(
                
                            content: Row(
                              children: <Widget>[
                
                                Expanded(child: TextField(
                
                                  controller: _textEditingController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                
                                    labelText: "Item",
                                    hintText:"Do flutter project",
                                    icon: Icon(Icons.note_add),
                                  ),
                                )),
                              ],
                            ),
                
                
                            actions: <Widget>[
                
                              FlatButton(onPressed: (){
                                handleSubmit(_textEditingController.text);
                                               
                                
                                              }, child:Text("Save") ),
                                              FlatButton(onPressed:(){
                                
                                
                                                Navigator.pop(context);
                                              } , child: Text("cancel")),
                                
                                            ],
                                          );
                                
                                
                                          showDialog(context: context,builder: (_){
                                
                                            return alert;
                                          });
                                
                                
                
                
                
                                  }
                
                
                                readTodolist()async{
                
                                  List just = await my.getAllUsers();
                                  print(just);
                
                
                                      just.forEach((data){
                
                                        NoDoItem noDoItem = NoDoItem.map(data);
                
                                        setState(() {
                                          
                                          _itemlist.insert(0,noDoItem);
                                        });
                
                
                
                                      });
                
                
                                
                
                
                
                                }

                                handleupdate(NoDoItem item,int index) async {
var alert = AlertDialog(
                
                            content: Row(
                              children: <Widget>[
                
                                Expanded(child: TextField(
                
                                  controller: _textEditingController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                
                                    labelText: "Item",
                                    hintText:"Do flutter project",
                                    icon: Icon(Icons.note_add),
                                  ),
                                )),
                              ],
                            ),
                
                
                            actions: <Widget>[
                
                              FlatButton(onPressed: ()async{

                                NoDoItem newItemUpdated = NoDoItem.fromMap({

                                    "itemName":_textEditingController.text,
                                    "dateCreated":dateformat(),
                                    "id":item.id,

                                });

                                checking(newItemUpdated, index);

                                print(await my.updateUser(newItemUpdated));



                               },child:Text("Save") ),
                                              FlatButton(onPressed:(){
                                
                                
                                                Navigator.pop(context);
                                              } , child: Text("cancel")),
                                
                                            ],
                                          );
                                           showDialog(context: context,builder: (_){
                                
                                            return alert;
                                          });



                                }

                                void checking(NoDoItem item,int id)async{



                                  




                                }

                                deleteitem(int id,int index) async{

                                  print("deleted");
                                 var deleteid= await my.deleteUser(id);
    setState(() {
      
      _itemlist.removeAt(deleteid);
    });
                                }
                                
                                  
         
}