import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

String mapKey = "AIzaSyDXua-cpwWEOGI5sekYuVRS2qEPEwT_pCo";

User? firebaseUser;

// Users? userCurrentInfo;

User? currentfirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;

StreamSubscription<Position>? rideStreamSubscription;

Position? currentPosition;

// Drivers? driversInformation;

String title = "";
double starCounter = 0.0;

String rideType = "";
