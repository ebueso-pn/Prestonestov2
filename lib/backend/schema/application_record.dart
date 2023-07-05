import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApplicationRecord extends FirestoreRecord {
  ApplicationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "application_id" field.
  int? _applicationId;
  int get applicationId => _applicationId ?? 0;
  bool hasApplicationId() => _applicationId != null;

  // "cuota" field.
  double? _cuota;
  double get cuota => _cuota ?? 0.0;
  bool hasCuota() => _cuota != null;

  // "tasa_mensual" field.
  double? _tasaMensual;
  double get tasaMensual => _tasaMensual ?? 0.0;
  bool hasTasaMensual() => _tasaMensual != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "date_applied" field.
  DateTime? _dateApplied;
  DateTime? get dateApplied => _dateApplied;
  bool hasDateApplied() => _dateApplied != null;

  // "decision_date" field.
  DateTime? _decisionDate;
  DateTime? get decisionDate => _decisionDate;
  bool hasDecisionDate() => _decisionDate != null;

  // "monto" field.
  double? _monto;
  double get monto => _monto ?? 0.0;
  bool hasMonto() => _monto != null;

  // "plazo_meses" field.
  double? _plazoMeses;
  double get plazoMeses => _plazoMeses ?? 0.0;
  bool hasPlazoMeses() => _plazoMeses != null;

  // "lat_long_app" field.
  LatLng? _latLongApp;
  LatLng? get latLongApp => _latLongApp;
  bool hasLatLongApp() => _latLongApp != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _applicationId = castToType<int>(snapshotData['application_id']);
    _cuota = castToType<double>(snapshotData['cuota']);
    _tasaMensual = castToType<double>(snapshotData['tasa_mensual']);
    _user = snapshotData['user'] as DocumentReference?;
    _dateApplied = snapshotData['date_applied'] as DateTime?;
    _decisionDate = snapshotData['decision_date'] as DateTime?;
    _monto = castToType<double>(snapshotData['monto']);
    _plazoMeses = castToType<double>(snapshotData['plazo_meses']);
    _latLongApp = snapshotData['lat_long_app'] as LatLng?;
    _status = castToType<int>(snapshotData['status']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('application')
          : FirebaseFirestore.instance.collectionGroup('application');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('application').doc();

  static Stream<ApplicationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ApplicationRecord.fromSnapshot(s));

  static Future<ApplicationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ApplicationRecord.fromSnapshot(s));

  static ApplicationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ApplicationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ApplicationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ApplicationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ApplicationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ApplicationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createApplicationRecordData({
  int? applicationId,
  double? cuota,
  double? tasaMensual,
  DocumentReference? user,
  DateTime? dateApplied,
  DateTime? decisionDate,
  double? monto,
  double? plazoMeses,
  LatLng? latLongApp,
  int? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'application_id': applicationId,
      'cuota': cuota,
      'tasa_mensual': tasaMensual,
      'user': user,
      'date_applied': dateApplied,
      'decision_date': decisionDate,
      'monto': monto,
      'plazo_meses': plazoMeses,
      'lat_long_app': latLongApp,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class ApplicationRecordDocumentEquality implements Equality<ApplicationRecord> {
  const ApplicationRecordDocumentEquality();

  @override
  bool equals(ApplicationRecord? e1, ApplicationRecord? e2) {
    return e1?.applicationId == e2?.applicationId &&
        e1?.cuota == e2?.cuota &&
        e1?.tasaMensual == e2?.tasaMensual &&
        e1?.user == e2?.user &&
        e1?.dateApplied == e2?.dateApplied &&
        e1?.decisionDate == e2?.decisionDate &&
        e1?.monto == e2?.monto &&
        e1?.plazoMeses == e2?.plazoMeses &&
        e1?.latLongApp == e2?.latLongApp &&
        e1?.status == e2?.status;
  }

  @override
  int hash(ApplicationRecord? e) => const ListEquality().hash([
        e?.applicationId,
        e?.cuota,
        e?.tasaMensual,
        e?.user,
        e?.dateApplied,
        e?.decisionDate,
        e?.monto,
        e?.plazoMeses,
        e?.latLongApp,
        e?.status
      ]);

  @override
  bool isValidKey(Object? o) => o is ApplicationRecord;
}
