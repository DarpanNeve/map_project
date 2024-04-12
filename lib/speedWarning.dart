import "package:flutter/material.dart";

import "package:map_project/speed_widget.dart";

Widget speedWarning(int speedInKm) {
  if (speedInKm > speedLimit - 5 && speedInKm != 0 && speedInKm < speedLimit) {
    return const Center(
      child: Text(
        "Approaching Speed Limit",
        style: TextStyle(
          fontSize: 40,
          color: Colors.red,
        ),
      ),
    );
  } else if (speedInKm != 0 && speedInKm > speedLimit) {
    return const Center(
      child: Text(
        "Speed Limit Exceeded",
        style: TextStyle(
          fontSize: 40,
          color: Colors.red,
        ),
      ),
    );
  } else if (speedInKm < speedLimit && speedInKm != 0) {
    return const Center(
      child: Text(
        "Driving Safely",
        style: TextStyle(
          fontSize: 40,
          color: Colors.green,
        ),
      ),
    );
  } else {
    return const Text(
      "Updating Data",
      style: TextStyle(
        fontSize: 40,
        color: Colors.green,
      ),
    );
  }
}
