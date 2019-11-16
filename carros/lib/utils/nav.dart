import 'package:flutter/material.dart';

push(context, page, {bool replace = false}) {

  if(!replace)
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));

  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return page;
  }));

}


pushReplacement(context, page) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}