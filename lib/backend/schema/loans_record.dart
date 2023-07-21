import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoansRecord extends FirestoreRecord {
  LoansRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ApplicationDocReference" field.
  DocumentReference? _applicationDocReference;
  DocumentReference? get applicationDocReference => _applicationDocReference;
  bool hasApplicationDocReference() => _applicationDocReference != null;

  // "UserDocReference" field.
  DocumentReference? _userDocReference;
  DocumentReference? get userDocReference => _userDocReference;
  bool hasUserDocReference() => _userDocReference != null;

  // "Pagare" field.
  String? _pagare;
  String get pagare => _pagare ?? '';
  bool hasPagare() => _pagare != null;

  // "Tasa" field.
  double? _tasa;
  double get tasa => _tasa ?? 0.0;
  bool hasTasa() => _tasa != null;

  // "Cuota" field.
  double? _cuota;
  double get cuota => _cuota ?? 0.0;
  bool hasCuota() => _cuota != null;

  // "Monto" field.
  double? _monto;
  double get monto => _monto ?? 0.0;
  bool hasMonto() => _monto != null;

  // "FechaFirma" field.
  DateTime? _fechaFirma;
  DateTime? get fechaFirma => _fechaFirma;
  bool hasFechaFirma() => _fechaFirma != null;

  // "Plazo" field.
  double? _plazo;
  double get plazo => _plazo ?? 0.0;
  bool hasPlazo() => _plazo != null;

  // "fecha_ultimo_pago" field.
  DateTime? _fechaUltimoPago;
  DateTime? get fechaUltimoPago => _fechaUltimoPago;
  bool hasFechaUltimoPago() => _fechaUltimoPago != null;

  // "fecha_primer_pago" field.
  DateTime? _fechaPrimerPago;
  DateTime? get fechaPrimerPago => _fechaPrimerPago;
  bool hasFechaPrimerPago() => _fechaPrimerPago != null;

  // "FechaCreado" field.
  DateTime? _fechaCreado;
  DateTime? get fechaCreado => _fechaCreado;
  bool hasFechaCreado() => _fechaCreado != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "Balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  void _initializeFields() {
    _applicationDocReference =
        snapshotData['ApplicationDocReference'] as DocumentReference?;
    _userDocReference = snapshotData['UserDocReference'] as DocumentReference?;
    _pagare = snapshotData['Pagare'] as String?;
    _tasa = castToType<double>(snapshotData['Tasa']);
    _cuota = castToType<double>(snapshotData['Cuota']);
    _monto = castToType<double>(snapshotData['Monto']);
    _fechaFirma = snapshotData['FechaFirma'] as DateTime?;
    _plazo = castToType<double>(snapshotData['Plazo']);
    _fechaUltimoPago = snapshotData['fecha_ultimo_pago'] as DateTime?;
    _fechaPrimerPago = snapshotData['fecha_primer_pago'] as DateTime?;
    _fechaCreado = snapshotData['FechaCreado'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _balance = castToType<double>(snapshotData['Balance']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('loans');

  static Stream<LoansRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LoansRecord.fromSnapshot(s));

  static Future<LoansRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LoansRecord.fromSnapshot(s));

  static LoansRecord fromSnapshot(DocumentSnapshot snapshot) => LoansRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LoansRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LoansRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LoansRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LoansRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLoansRecordData({
  DocumentReference? applicationDocReference,
  DocumentReference? userDocReference,
  String? pagare,
  double? tasa,
  double? cuota,
  double? monto,
  DateTime? fechaFirma,
  double? plazo,
  DateTime? fechaUltimoPago,
  DateTime? fechaPrimerPago,
  DateTime? fechaCreado,
  String? status,
  double? balance,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ApplicationDocReference': applicationDocReference,
      'UserDocReference': userDocReference,
      'Pagare': pagare,
      'Tasa': tasa,
      'Cuota': cuota,
      'Monto': monto,
      'FechaFirma': fechaFirma,
      'Plazo': plazo,
      'fecha_ultimo_pago': fechaUltimoPago,
      'fecha_primer_pago': fechaPrimerPago,
      'FechaCreado': fechaCreado,
      'status': status,
      'Balance': balance,
    }.withoutNulls,
  );

  return firestoreData;
}

class LoansRecordDocumentEquality implements Equality<LoansRecord> {
  const LoansRecordDocumentEquality();

  @override
  bool equals(LoansRecord? e1, LoansRecord? e2) {
    return e1?.applicationDocReference == e2?.applicationDocReference &&
        e1?.userDocReference == e2?.userDocReference &&
        e1?.pagare == e2?.pagare &&
        e1?.tasa == e2?.tasa &&
        e1?.cuota == e2?.cuota &&
        e1?.monto == e2?.monto &&
        e1?.fechaFirma == e2?.fechaFirma &&
        e1?.plazo == e2?.plazo &&
        e1?.fechaUltimoPago == e2?.fechaUltimoPago &&
        e1?.fechaPrimerPago == e2?.fechaPrimerPago &&
        e1?.fechaCreado == e2?.fechaCreado &&
        e1?.status == e2?.status &&
        e1?.balance == e2?.balance;
  }

  @override
  int hash(LoansRecord? e) => const ListEquality().hash([
        e?.applicationDocReference,
        e?.userDocReference,
        e?.pagare,
        e?.tasa,
        e?.cuota,
        e?.monto,
        e?.fechaFirma,
        e?.plazo,
        e?.fechaUltimoPago,
        e?.fechaPrimerPago,
        e?.fechaCreado,
        e?.status,
        e?.balance
      ]);

  @override
  bool isValidKey(Object? o) => o is LoansRecord;
}
