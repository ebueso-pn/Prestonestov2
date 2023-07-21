import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DocumentsRecord extends FirestoreRecord {
  DocumentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "pagare" field.
  String? _pagare;
  String get pagare => _pagare ?? '';
  bool hasPagare() => _pagare != null;

  // "UserDocReference" field.
  DocumentReference? _userDocReference;
  DocumentReference? get userDocReference => _userDocReference;
  bool hasUserDocReference() => _userDocReference != null;

  // "income_verification" field.
  List<String>? _incomeVerification;
  List<String> get incomeVerification => _incomeVerification ?? const [];
  bool hasIncomeVerification() => _incomeVerification != null;

  void _initializeFields() {
    _pagare = snapshotData['pagare'] as String?;
    _userDocReference = snapshotData['UserDocReference'] as DocumentReference?;
    _incomeVerification = getDataList(snapshotData['income_verification']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('documents');

  static Stream<DocumentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DocumentsRecord.fromSnapshot(s));

  static Future<DocumentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DocumentsRecord.fromSnapshot(s));

  static DocumentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DocumentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DocumentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DocumentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DocumentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DocumentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDocumentsRecordData({
  String? pagare,
  DocumentReference? userDocReference,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'pagare': pagare,
      'UserDocReference': userDocReference,
    }.withoutNulls,
  );

  return firestoreData;
}

class DocumentsRecordDocumentEquality implements Equality<DocumentsRecord> {
  const DocumentsRecordDocumentEquality();

  @override
  bool equals(DocumentsRecord? e1, DocumentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.pagare == e2?.pagare &&
        e1?.userDocReference == e2?.userDocReference &&
        listEquality.equals(e1?.incomeVerification, e2?.incomeVerification);
  }

  @override
  int hash(DocumentsRecord? e) => const ListEquality()
      .hash([e?.pagare, e?.userDocReference, e?.incomeVerification]);

  @override
  bool isValidKey(Object? o) => o is DocumentsRecord;
}
