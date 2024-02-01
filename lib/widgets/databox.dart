import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.purple),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 3),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 3),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3),
  ),
);
void showBottomSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,style: const TextStyle(fontSize: 30),),
    backgroundColor: color,
    duration: const Duration(seconds: 4),
    action: SnackBarAction(label: "OK",onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();},textColor: Colors.black,),
  ));
}
void showDialogWithFields(BuildContext context, message, String display) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: ((context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          title: Text(display,
            style: TextStyle(
              color: Colors.red[900],
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              SizedBox(
                height: 50,
                width: 73,
                child: ElevatedButton(onPressed: (){Navigator.of(context).pop();},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[900],
                  elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                ),
                  child: const Text("OK",),
                ),
              ),
              SizedBox(
                  height: 50,
                  width: 95,
                  child: ElevatedButton(onPressed: () async{
                    Navigator.of(context).pop();
                    showBottomSnackBar(context, Colors.teal[700], message);
                    },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("More Info",),
              ))
            ]
          ),
        );
      }));
    },
  );
}







// content: ListView(
// shrinkWrap: true,
// children: [
// TextFormField(
// controller: emailController,
// decoration: InputDecoration(hintText: 'Email'),
// ),
// TextFormField(
// controller: messageController,
// decoration: InputDecoration(hintText: 'Message'),
// ),
// ],
// ),
// actions: [
// TextButton(
// onPressed: () => Navigator.pop(context),
// child: Text('Cancel'),
// ),
// TextButton(
// onPressed: () {
// // Send them to your email maybe?
// var email = emailController.text;
// var message = messageController.text;
// Navigator.pop(context);
// },
// child: Text('Send'),
// ),
// ],
