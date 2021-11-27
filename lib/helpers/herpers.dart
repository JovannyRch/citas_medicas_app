import 'package:flutter/material.dart';

void navigateTo(BuildContext context, StatefulWidget c) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => c),
  );
}

void navigateToReplace(BuildContext context, StatefulWidget c) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => c),
  );
}
