import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'studnets_list_page_widget.dart' show StudnetsListPageWidget;
import 'package:flutter/material.dart';

class StudnetsListPageModel extends FlutterFlowModel<StudnetsListPageWidget> {
  ///  Local state fields for this page.

  int? intSizeData;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  int? outputNewCount;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  StudentsRecord? outputDataSingle;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
