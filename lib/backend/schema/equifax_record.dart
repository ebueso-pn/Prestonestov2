import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EquifaxRecord extends FirestoreRecord {
  EquifaxRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "candidateInfo" field.
  List<String>? _candidateInfo;
  List<String> get candidateInfo => _candidateInfo ?? const [];
  bool hasCandidateInfo() => _candidateInfo != null;

  // "UserDocReference" field.
  DocumentReference? _userDocReference;
  DocumentReference? get userDocReference => _userDocReference;
  bool hasUserDocReference() => _userDocReference != null;

  // "ApplicationDocReference" field.
  DocumentReference? _applicationDocReference;
  DocumentReference? get applicationDocReference => _applicationDocReference;
  bool hasApplicationDocReference() => _applicationDocReference != null;

  void _initializeFields() {
    _candidateInfo = getDataList(snapshotData['candidateInfo']);
    _userDocReference = snapshotData['UserDocReference'] as DocumentReference?;
    _applicationDocReference =
        snapshotData['ApplicationDocReference'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('equifax');

  static Stream<EquifaxRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EquifaxRecord.fromSnapshot(s));

  static Future<EquifaxRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EquifaxRecord.fromSnapshot(s));

  static EquifaxRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EquifaxRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EquifaxRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EquifaxRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EquifaxRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EquifaxRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEquifaxRecordData({
  DocumentReference? userDocReference,
  DocumentReference? applicationDocReference,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'UserDocReference': userDocReference,
      'ApplicationDocReference': applicationDocReference,
    }.withoutNulls,
  );

  return firestoreData;
}

class EquifaxRecordDocumentEquality implements Equality<EquifaxRecord> {
  const EquifaxRecordDocumentEquality();

  @override
  bool equals(EquifaxRecord? e1, EquifaxRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.candidateInfo, e2?.candidateInfo) &&
        e1?.userDocReference == e2?.userDocReference &&
        e1?.applicationDocReference == e2?.applicationDocReference;
  }

  @override
  int hash(EquifaxRecord? e) => const ListEquality().hash(
      [e?.candidateInfo, e?.userDocReference, e?.applicationDocReference]);

  @override
  bool isValidKey(Object? o) => o is EquifaxRecord;
}
