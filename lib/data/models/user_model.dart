import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.maidenName,
    required super.age,
    required super.gender,
    required super.email,
    required super.phone,
    required super.username,
    required super.password,
    required super.birthDate,
    required super.image,
    required super.bloodGroup,
    required super.height,
    required super.weight,
    required super.eyeColor,
    required super.hair,
    required super.ip,
    required super.address,
    required super.macAddress,
    required super.university,
    required super.bank,
    required super.company,
    required super.ein,
    required super.ssn,
    required super.userAgent,
    required super.crypto,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      maidenName: json['maidenName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      birthDate: json['birthDate'] ?? '',
      image: json['image'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      eyeColor: json['eyeColor'] ?? '',
      hair: HairModel.fromJson(json['hair'] ?? {}),
      ip: json['ip'] ?? '',
      address: AddressModel.fromJson(json['address'] ?? {}),
      macAddress: json['macAddress'] ?? '',
      university: json['university'] ?? '',
      bank: BankModel.fromJson(json['bank'] ?? {}),
      company: CompanyModel.fromJson(json['company'] ?? {}),
      ein: json['ein'] ?? '',
      ssn: json['ssn'] ?? '',
      userAgent: json['userAgent'] ?? '',
      crypto: CryptoModel.fromJson(json['crypto'] ?? {}),
      role: json['role'] ?? '',
    );
  }
}

class HairModel extends Hair {
  const HairModel({required super.color, required super.type});

  factory HairModel.fromJson(Map<String, dynamic> json) {
    return HairModel(
      color: json['color'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class AddressModel extends Address {
  const AddressModel({
    required super.address,
    required super.city,
    required super.state,
    required super.stateCode,
    required super.postalCode,
    required super.coordinates,
    required super.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      stateCode: json['stateCode'] ?? '',
      postalCode: json['postalCode'] ?? '',
      coordinates: CoordinatesModel.fromJson(json['coordinates'] ?? {}),
      country: json['country'] ?? '',
    );
  }
}

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({required super.lat, required super.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }
}

class BankModel extends Bank {
  const BankModel({
    required super.cardExpire,
    required super.cardNumber,
    required super.cardType,
    required super.currency,
    required super.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      cardExpire: json['cardExpire'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      cardType: json['cardType'] ?? '',
      currency: json['currency'] ?? '',
      iban: json['iban'] ?? '',
    );
  }
}

class CompanyModel extends Company {
  const CompanyModel({
    required super.department,
    required super.name,
    required super.title,
    required super.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      department: json['department'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      address: AddressModel.fromJson(json['address'] ?? {}),
    );
  }
}

class CryptoModel extends Crypto {
  const CryptoModel({required super.coin, required super.wallet, required super.network});

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      coin: json['coin'] ?? '',
      wallet: json['wallet'] ?? '',
      network: json['network'] ?? '',
    );
  }
}

