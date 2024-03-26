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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                            filled: true,
                            fillColor: Colors.white, // Set background color
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0), // Adjust padding
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Add space between text field and icon button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            BlocProvider.of<SearchBloc>(context).add(
                              PerformSearchEvent(textEditingController.text),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(
                                    0xff4FB6EC) // Set button background color
                                ),
                            child: Icon(
                              Icons.search,
                              color: Colors.white, // Set icon color
                            ),
                          ),
                        ),
                      ),
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
                                  token: searchResult[index]['token'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(searchResult[index]['image']),
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
      ),
    );
  }
}
