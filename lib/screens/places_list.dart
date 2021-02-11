import 'package:flutter/material.dart';
import '../screens/place_detail.dart';
import '../providers/places.dart';
import 'package:provider/provider.dart';
import './add_place.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<Places>(
                      builder: (ctx, places, child) => places.items.length <= 0
                          ? child
                          : ListView.builder(
                              itemCount: places.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(places.items[i].image),
                                    ),
                                    title: Text(places.items[i].title),
                                    subtitle:
                                        Text(places.items[i].location.address),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          PlaceDetailScreen.routeName,
                                          arguments: places.items[i].id);
                                    },
                                  )),
                      child: Center(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('There is no places yet, Start adding some'),
                            FlatButton.icon(
                              label: Text('Add Place'),
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AddPlaceScreen.routeName);
                              },
                            )
                          ],
                        ),
                      )),
        ));
  }
}
