import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:tastypie/tastypie.dart';

class ErrorMsgWidget extends StatefulWidget {
  ErrorMsgWidget({Key? key}) : super(key: key) {}
  @override
  State<ErrorMsgWidget> createState() => _ErrorMsgWidgetState();
}

class _ErrorMsgWidgetState extends State<ErrorMsgWidget> with Topping {
  String? _error;
  String? _errorLast;
  StreamController<bool> _streamController = StreamController<bool>();
  _ErrorMsgWidgetState() {
    addInputTaste('error', _msg, onlyInTheLayer: false);
  }
  void _msg(dynamic data, String topic, int state, ITasteOutput? out) {
    print('_ErrorMsgWidgetState-> $topic:$state');
    _error = data;
    _streamController.add(true);

    // if (WidgetsBinding.instance != null)
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     print('_ErrorMsgWidgetState-> set state');
    //     setState(() {
    //       try {
    //         _error = data as String;
    //       } catch (e) {
    //         _error = 'Error _ErrorMsgWidgetState $e';
    //         print(_error);
    //       }
    //     });
    //   });
    // else
    //   setState(() {
    //     try {
    //       _error = data as String;
    //     } catch (e) {
    //       _error = 'Error _ErrorMsgWidgetState $e';
    //       print(_error);
    //     }
    //   });
    // }
  }

  @override
  void dispose() {
    if (own_layer != null) {
      print('_ErrorMsgWidgetState Remove from layer');
      own_layer!.removeTopping(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('${tag.name} count:${tag.count}');
    if (own_layer == null) {
      print('ErrorMsgWidget add to layer');
      ViewLayer.of(context).addTopping(this);
      ViewLayer.of(context).rebuildDirectNet();
    }
    // print('ErrorMsgWidget rebuild');

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, data) {
        // print('Error msg call');
        if (_error != null) {
          // showDialog<String>(
          //   context: context,
          //   builder: (BuildContext context) => AlertDialog(
          //     title: const Text('AlertDialog Title'),
          //     content: const Text('AlertDialog description'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'Cancel'),
          //         child: const Text('Cancel'),
          //       ),
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),
          // );
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            // print('ErrorMsgWidget send error to ScaffoldMessenger');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_error!),
                backgroundColor: Color.fromARGB(0xFF, 0x8A, 0x22, 0x22),
              ),
            );
            _error = null;
          });
        }
        return Text('');
      },
    );
  }
}
