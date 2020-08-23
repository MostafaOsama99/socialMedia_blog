import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/providers/posts_provider.dart';

import 'package:task1/widgets/post_widget.dart';
import '../demo_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Posts>(context).fetchPosts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> refreshPosts() async => await Provider.of<Posts>(context, listen: false).fetchPosts();

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              title: Text(
                'My Blog',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Navigator.pushNamed(context, 'AddPost'),
                )
              ],
            )),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
              onRefresh: refreshPosts,
              child: ListView.builder(
                  itemCount: posts.posts.length,
                  itemBuilder: (context, i) => ChangeNotifierProvider.value(
                      value: posts.posts[i], child: PostWidget()),
                ),
            ));
  }
}
