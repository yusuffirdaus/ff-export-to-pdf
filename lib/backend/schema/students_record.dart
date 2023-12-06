import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class StudentsRecord extends FirestoreRecord {
  StudentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "fullname" field.
  String? _fullname;
  String get fullname => _fullname ?? '';
  bool hasFullname() => _fullname != null;

  // "studentID" field.
  String? _studentID;
  String get studentID => _studentID ?? '';
  bool hasStudentID() => _studentID != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "studentPhoto" field.
  String? _studentPhoto;
  String get studentPhoto => _studentPhoto ?? '';
  bool hasStudentPhoto() => _studentPhoto != null;

  void _initializeFields() {
    _fullname = snapshotData['fullname'] as String?;
    _studentID = snapshotData['studentID'] as String?;
    _address = snapshotData['address'] as String?;
    _studentPhoto = snapshotData['studentPhoto'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('students');

  static Stream<StudentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StudentsRecord.fromSnapshot(s));

  static Future<StudentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StudentsRecord.fromSnapshot(s));

  static StudentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StudentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StudentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StudentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StudentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StudentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStudentsRecordData({
  String? fullname,
  String? studentID,
  String? address,
  String? studentPhoto,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'fullname': fullname,
      'studentID': studentID,
      'address': address,
      'studentPhoto': studentPhoto,
    }.withoutNulls,
  );

  return firestoreData;
}

class StudentsRecordDocumentEquality implements Equality<StudentsRecord> {
  const StudentsRecordDocumentEquality();

  @override
  bool equals(StudentsRecord? e1, StudentsRecord? e2) {
    return e1?.fullname == e2?.fullname &&
        e1?.studentID == e2?.studentID &&
        e1?.address == e2?.address &&
        e1?.studentPhoto == e2?.studentPhoto;
  }

  @override
  int hash(StudentsRecord? e) => const ListEquality()
      .hash([e?.fullname, e?.studentID, e?.address, e?.studentPhoto]);

  @override
  bool isValidKey(Object? o) => o is StudentsRecord;
}
