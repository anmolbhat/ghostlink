import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../messageContainer.dart';
import 'chatViewModel.dart';

class ChatPage extends StatelessWidget {

  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Delay the scrolling to allow the ListView to be fully rendered
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });

    final chatViewModel = Provider.of<ChatViewModel>(context); // Collection on the right
    String person = chatViewModel.person;
    String message = chatViewModel.message;
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30,),
                        Container(
                          height: 100,
                          width: 200,
                          child: TextFormField(
                            initialValue: person,
                            decoration: const InputDecoration(
                              labelText: 'Person',
                              prefixIcon: Icon(
                                Icons.verified_user,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) => chatViewModel.setPerson(value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 125,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[800],
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              chatViewModel.saveChat();
                              chatViewModel.getMessages();
                            },
                            child: const Text("Refresh"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Consumer<ChatViewModel>(
                  builder: (context,chatviewmodel,_) {
                    chatViewModel.sort();
                    final List<MessageTest> snapshot = chatViewModel.fullList; //
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount:snapshot.length,
                              itemBuilder: (context, index) {
                                final message = snapshot[index];
                                String sender = snapshot[index].sentByMe ? 'Me' : 'Anonymous';
                                return MessageTile(
                                    message: snapshot[index].text,
                                    sender: sender,
                                    sentByMe: snapshot[index].sentByMe);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(width: 5,),
                              Expanded(
                                child: TextFormField(
                                  controller: chatViewModel.controller,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.purple, width: 3),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                    labelText: 'Message',
                                    prefixIcon: const Icon(
                                      Icons.messenger,
                                      color: Colors.black,
                                    )
                                  ),
                                  onChanged: (value) => chatViewModel.setMessage(value),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  chatViewModel.sendMessage();
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

