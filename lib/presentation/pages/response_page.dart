import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_unleashed/data/model/todo.dart';
import 'package:flutter_unleashed/presentation/widgets/response_page_widgets.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({Key key}) : super(key: key);

  @override
  _ResponsePageState createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage>
    with AutomaticKeepAliveClientMixin {
  String _errorMessage = '';
  bool _isLoading = true;
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  List<String> _filterByOptions = ['all', 'completed', 'incomplete'];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  @override
  bool get wantKeepAlive => true;

  void _filterBy(String filterby) {
    FocusScope.of(context).requestFocus(new FocusNode());
    switch (filterby) {
      case 'all':
        setState(() {
          _filteredTodos = _todos;
        });
        break;
      case 'incomplete':
        setState(() {
          _filteredTodos = _todos.where((todo) => !todo.completed).toList();
        });
        break;
      case 'completed':
        setState(() {
          _filteredTodos = _todos.where((todo) => todo.completed).toList();
        });
        break;
      default:
    }
  }

  //function to fetch todos from api
  void _fetchTodos() async {
    bool hasInternetConnection = await DataConnectionChecker().hasConnection;
    if (hasInternetConnection) {
      try {
        Response response = await Dio().get(
          "https://jsonplaceholder.typicode.com/todos?_limit=5",
        );

        final todosList = todoFromJson(jsonEncode(response.data));

        setState(() {
          _todos = todosList;
          _filteredTodos = todosList;
          _isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          _errorMessage = 'server failure occurred';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'poor or no internet connection';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(_todos.length);
    //render a loader when making http request
    if (_isLoading) {
      return Loader();
    }

    //render an errormessage when fetching data fails
    if (_errorMessage.isNotEmpty) {
      return DataFetchingErrorWidget(
          errorMessage: _errorMessage, onPressed: _fetchTodos);
    }

    //render listview when fetching datais successfully

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text(
            'Filter Todos by',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FilterByDropDown(
            items: _filterByOptions,
            onItemSelected: _filterBy,
            hintText: 'all',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = _filteredTodos[index];
              final status = todo.completed ? 'Completed' : 'Incomplete';
              Color bgColor;

              if (index % 2 == 0) {
                bgColor = Color(0xFFDFEAFB);
              } else if (index % 3 == 0) {
                bgColor = Color(0xFFEDE1F9);
              } else {
                bgColor = Color(0xFFDFFDDB);
              }

              return AnimationConfiguration.staggeredList(
                key: PageStorageKey('${todo.id}'),
                delay: Duration(microseconds: 100),
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * (1 / 2.7),
                          width: MediaQuery.of(context).size.width * (1 / 5),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '#${todo.id.toString()}',
                            style: responsePageTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            height:
                                MediaQuery.of(context).size.width * (1 / 2.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${todo.title}',
                                    style: responsePageTextStyle),
                                SizedBox(height: 5),
                                Text(
                                  'Status: $status',
                                  style: responsePageTextStyle.copyWith(
                                      color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
