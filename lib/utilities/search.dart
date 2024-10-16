import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../screens/profilePage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration:
                  const InputDecoration(labelText: 'Search for a user...'),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where(
                'username',
                isGreaterThanOrEqualTo: searchController.text,
              )
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: (snapshot.data! as dynamic).docs[index]['uid'],
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                      radius: 16,
                    ),
                    title: Text(
                      (snapshot.data! as dynamic).docs[index]['username'],
                    ),
                  ),
                );
              },
            );
          },
        )
        // : FutureBuilder(
        //     future: FirebaseFirestore.instance
        //         .collection('posts')
        //         .orderBy('datePublished')
        //         .get(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       return GridView.custom(
        //         crossAxisCount: 3,
        //         itemCount: (snapshot.data! as dynamic).docs.length,
        //         itemBuilder: (context, index) => Image.network(
        //           (snapshot.data! as dynamic).docs[index]['postUrl'],
        //           fit: BoxFit.cover,
        //         ),
        //         StaggeredTile.count(
        //             (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
        //         mainAxisSpacing: 8.0,
        //         crossAxisSpacing: 8.0,
        //       );
        //     },
        //   ),
        );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   _SearchPage createState() => _SearchPage();
// }

// // class _SearchPage extends State<SearchScreen> {
//   String name = "";
//   List<Map<String, dynamic>> data = [
//     {
//       'name': 'John',
//       'image':
//           'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
//       'email': 'john@gmail.com'
//     },
//     {
//       'name': 'Eric',
//       'image':
//           'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
//       'email': 'eric@gmail.com'
//     },
//     {
//       'name': 'Mark',
//       'image':
//           'https://i.picsum.photos/id/449/200/300.jpg?grayscale&hmac=GcAk7XLOGeBrqzrEpBjAzBcZFJ9bvyMwvL1QENQ23Zc',
//       'email': 'mark@gmail.com'
//     },
//     {
//       'name': 'Ela',
//       'image':
//           'https://i.picsum.photos/id/3/200/300.jpg?blur=2&hmac=CgtEzNwC4BLEa1z5r0oGOsZPj5wJlqjU615MLuFillY',
//       'email': 'ela@gmail.com'
//     },
//     {
//       'name': 'Sue',
//       'image':
//           'https://i.picsum.photos/id/497/200/300.jpg?hmac=IqTAOsl408FW-5QME1woScOoZJvq246UqZGGR9UkkkY',
//       'email': 'sue@gmail.com'
//     },
//     {
//       'name': 'Lothe',
//       'image':
//           'https://i.picsum.photos/id/450/200/300.jpg?hmac=EAnz3Z3i5qXfaz54l0aegp_-5oN4HTwiZG828ZGD7GM',
//       'email': 'lothe@gmail.com'
//     },
//     {
//       'name': 'Alyssa',
//       'image':
//           'https://i.picsum.photos/id/169/200/200.jpg?hmac=MquoCIcsCP_IxfteFmd8LfVF7NCoRre282nO9gVD0Yc',
//       'email': 'Alyssa@gmail.com'
//     },
//     {
//       'name': 'Nichols',
//       'image':
//           'https://i.picsum.photos/id/921/200/200.jpg?hmac=6pwJUhec4NqIAFxrha-8WXGa8yI1pJXKEYCWMSHroSU',
//       'email': 'Nichols@gmail.com'
//     },
//     {
//       'name': 'Welch',
//       'image':
//           'https://i.picsum.photos/id/845/200/200.jpg?hmac=KMGSD70gM0xozvpzPM3kHIwwA2TRlVQ6d2dLW_b1vDQ',
//       'email': 'Welch@gmail.com'
//     },
//     {
//       'name': 'Delacruz',
//       'image':
//           'https://i.picsum.photos/id/250/200/200.jpg?hmac=23TaEG1txY5qYZ70amm2sUf0GYKo4v7yIbN9ooyqWzs',
//       'email': 'Delacruz@gmail.com'
//     },
//     {
//       'name': 'Tania',
//       'image':
//           'https://i.picsum.photos/id/237/200/200.jpg?hmac=zHUGikXUDyLCCmvyww1izLK3R3k8oRYBRiTizZEdyfI',
//       'email': 'Tania@gmail.com'
//     },
//     {
//       'name': 'Jeanie',
//       'image':
//           'https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU',
//       'email': 'Jeanie@gmail.com'
//     },
//     {
//       'name': 'Gerrie',
//       'image':
//           'https://i.picsum.photos/id/237/200/200.jpg?hmac=zHUGikXUDyLCCmvyww1izLK3R3k8oRYBRiTizZEdyfI',
//       'email': 'geariecool@gmail.com'
//     },
//     {
//       'name': 'Fauzan',
//       'image':
//           'https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU',
//       'email': 'fauzan@gmail.com'
//     },
//     {
//       'name': 'Daffa',
//       'image':
//           'https://i.picsum.photos/id/237/200/200.jpg?hmac=zHUGikXUDyLCCmvyww1izLK3R3k8oRYBRiTizZEdyfI',
//       'email': 'daffa@gmail.com'
//     },
//     {
//       'name': 'Wahyu',
//       'image':
//           'https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU',
//       'email': 'wahyu@gmail.com'
//     }
//   ];

//   addData() async {
//     for (var element in data) {
//       FirebaseFirestore.instance.collection('user').add(element);
//     }
//     print('all data added');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     // addData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Card(
//           child: TextField(
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search), hintText: 'Search...'),
//             onChanged: (val) {
//               setState(() {
//                 name = val;
//               });
//             },
//           ),
//         )),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('user').snapshots(),
//           builder: (context, snapshots) {
//             return (snapshots.connectionState == ConnectionState.waiting)
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : ListView.builder(
//                     itemCount: snapshots.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var data = snapshots.data!.docs[index].data()
//                           as Map<String, dynamic>;

//                       if (name.isEmpty) {
//                         return ListTile(
//                           title: Text(
//                             data['name'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             data['email'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(data['image']),
//                           ),
//                         );
//                       }
//                       if (data['name']
//                           .toString()
//                           .toLowerCase()
//                           .startsWith(name.toLowerCase())) {
//                         return ListTile(
//                           title: Text(
//                             data['name'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             data['email'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(data['image']),
//                           ),
//                         );
//                       }
//                       return Container();
//                     });
//           },
//         ));
//   }
// }
