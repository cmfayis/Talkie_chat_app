import 'package:chat_app/application/feature/personalData/personalchat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_bloc.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 31, 117, 101),
        title: const Text("Search"),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchUserNotFound) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is SearchError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          List<Map> searchResult = [];

          if (state is SearchLoaded) {
            searchResult = state.searchResult;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: "Type username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<SearchBloc>(context).add(
                          PerformSearchEvent(textEditingController.text),
                        );
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
              if (searchResult.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                             
                                friendId: searchResult[index]['uid'],
                                friendName: searchResult[index]['Name'],
                                friendImage: searchResult[index]['image'],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(                           
                            backgroundImage: NetworkImage(searchResult[index]['image']),
                          ),
           
                          title: Text(searchResult[index]['Name']),
                          subtitle: Text(searchResult[index]['Email']),
                          trailing: const Icon(Icons.message),
                        ),
                      );
                    },
                  ),
                )
              else if (state is SearchLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
