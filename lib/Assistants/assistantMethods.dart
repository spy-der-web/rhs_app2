import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rhs_app/Assistants/requestAssistant.dart';
import 'package:rhs_app/DataHandler/appData.dart';
import 'package:rhs_app/Models/address.dart';
import 'package:rhs_app/Models/directionDetails.dart';
import 'package:rhs_app/configMaps.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position, context) async
  {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        //placeAddress = response["results"][0]["formatted_address"];
        st1 = response["results"][0]["address_components"][4]["long_name"];
        st2 = response["results"][0]["address_components"][7]["long_name"];
        st3 = response["results"][0]["address_components"][6]["long_name"];
        st4 = response["results"][0]["address_components"][9]["long_name"];
        placeAddress = st1 + "," +st2 + "," + st3 + "," + st4;

        Address userPickUpAddress = new Address(longitude: position.longitude, latitude: position.latitude, placeName: placeAddress, placeFormattedAddress: placeAddress, placeId: "asf");
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placeAddress;

        // ignore: unnecessary_statements
        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
       }


    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async
  {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=$finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if(res == "failed")
      {
        return null;
      }

    DirectionDetails directionDetails = DirectionDetails(distanceValue: 0, durationValue: 0, distanceText: "", durationText: "", encodedPoints: "");

    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["distance"]["text"];

    return directionDetails;
  }
}