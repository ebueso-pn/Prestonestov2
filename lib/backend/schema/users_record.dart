import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "DNI" field.
  String? _dni;
  String get dni => _dni ?? '';
  bool hasDni() => _dni != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "nombres" field.
  String? _nombres;
  String get nombres => _nombres ?? '';
  bool hasNombres() => _nombres != null;

  // "apellidos" field.
  String? _apellidos;
  String get apellidos => _apellidos ?? '';
  bool hasApellidos() => _apellidos != null;

  // "calle" field.
  String? _calle;
  String get calle => _calle ?? '';
  bool hasCalle() => _calle != null;

  // "colonia" field.
  String? _colonia;
  String get colonia => _colonia ?? '';
  bool hasColonia() => _colonia != null;

  // "descripcion_direccion" field.
  String? _descripcionDireccion;
  String get descripcionDireccion => _descripcionDireccion ?? '';
  bool hasDescripcionDireccion() => _descripcionDireccion != null;

  // "ciudad" field.
  String? _ciudad;
  String get ciudad => _ciudad ?? '';
  bool hasCiudad() => _ciudad != null;

  // "lat_long" field.
  LatLng? _latLong;
  LatLng? get latLong => _latLong;
  bool hasLatLong() => _latLong != null;

  // "income_verification" field.
  String? _incomeVerification;
  String get incomeVerification => _incomeVerification ?? '';
  bool hasIncomeVerification() => _incomeVerification != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _dni = snapshotData['DNI'] as String?;
    _address = snapshotData['address'] as String?;
    _nombres = snapshotData['nombres'] as String?;
    _apellidos = snapshotData['apellidos'] as String?;
    _calle = snapshotData['calle'] as String?;
    _colonia = snapshotData['colonia'] as String?;
    _descripcionDireccion = snapshotData['descripcion_direccion'] as String?;
    _ciudad = snapshotData['ciudad'] as String?;
    _latLong = snapshotData['lat_long'] as LatLng?;
    _incomeVerification = snapshotData['income_verification'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? dni,
  String? address,
  String? nombres,
  String? apellidos,
  String? calle,
  String? colonia,
  String? descripcionDireccion,
  String? ciudad,
  LatLng? latLong,
  String? incomeVerification,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'DNI': dni,
      'address': address,
      'nombres': nombres,
      'apellidos': apellidos,
      'calle': calle,
      'colonia': colonia,
      'descripcion_direccion': descripcionDireccion,
      'ciudad': ciudad,
      'lat_long': latLong,
      'income_verification': incomeVerification,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.dni == e2?.dni &&
        e1?.address == e2?.address &&
        e1?.nombres == e2?.nombres &&
        e1?.apellidos == e2?.apellidos &&
        e1?.calle == e2?.calle &&
        e1?.colonia == e2?.colonia &&
        e1?.descripcionDireccion == e2?.descripcionDireccion &&
        e1?.ciudad == e2?.ciudad &&
        e1?.latLong == e2?.latLong &&
        e1?.incomeVerification == e2?.incomeVerification;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.dni,
        e?.address,
        e?.nombres,
        e?.apellidos,
        e?.calle,
        e?.colonia,
        e?.descripcionDireccion,
        e?.ciudad,
        e?.latLong,
        e?.incomeVerification
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
