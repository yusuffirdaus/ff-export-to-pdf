import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'add_user_chat_model.dart';
export 'add_user_chat_model.dart';

class AddUserChatWidget extends StatefulWidget {
  const AddUserChatWidget({super.key});

  @override
  _AddUserChatWidgetState createState() => _AddUserChatWidgetState();
}

class _AddUserChatWidgetState extends State<AddUserChatWidget> {
  late AddUserChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddUserChatModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select user',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
              child: StreamBuilder<List<UsersRecord>>(
                stream: queryUsersRecord(
                  queryBuilder: (usersRecord) => usersRecord.where(
                    'uid',
                    isNotEqualTo: currentUserReference?.id,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<UsersRecord> listViewUsersRecordList = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewUsersRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewUsersRecord =
                          listViewUsersRecordList[listViewIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          var chatsRecordReference =
                              ChatsRecord.collection.doc();
                          await chatsRecordReference.set({
                            ...createChatsRecordData(
                              userA: currentUserReference,
                              userB: listViewUsersRecord.reference,
                              lastMessage: 'no chat yet',
                            ),
                            ...mapToFirestore(
                              {
                                'users': [currentUserReference],
                                'last_message_time':
                                    FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          _model.outputChatUser =
                              ChatsRecord.getDocumentFromData({
                            ...createChatsRecordData(
                              userA: currentUserReference,
                              userB: listViewUsersRecord.reference,
                              lastMessage: 'no chat yet',
                            ),
                            ...mapToFirestore(
                              {
                                'users': [currentUserReference],
                                'last_message_time': DateTime.now(),
                              },
                            ),
                          }, chatsRecordReference);

                          await _model.outputChatUser!.reference.update({
                            ...mapToFirestore(
                              {
                                'users': FieldValue.arrayUnion(
                                    [listViewUsersRecord.reference]),
                              },
                            ),
                          });
                          Navigator.pop(context);

                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(
                            valueOrDefault<String>(
                              listViewUsersRecord.displayName,
                              'no name',
                            ),
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          subtitle: Text(
                            listViewUsersRecord.email,
                            style: FlutterFlowTheme.of(context).labelMedium,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
