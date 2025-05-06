class TapperModel {
  BigInt id;
  String nik;
  String name;
  String? kemandoran;
  String? subDivisi;

  TapperModel({
    required this.id,
    required this.nik,
    required this.name,
    this.kemandoran,
    this.subDivisi,
  });

  static List<TapperModel> getTapperList() {
    List<TapperModel> tapperList = [];
    tapperList.add(
      TapperModel(
        id: BigInt.from(1),
        nik: '123456789',
        name: 'John Doe',
        kemandoran: 'Mr. X',
        subDivisi: 'Sub Divisi A',
      ),
    );

    tapperList.add(
      TapperModel(
        id: BigInt.from(2),
        nik: '987654321',
        name: 'Jane Smith',
        kemandoran: 'Mr. Y',
        subDivisi: 'Sub Divisi B',
      ),
    );

    tapperList.add(
      TapperModel(
        id: BigInt.from(3),
        nik: '456789123',
        name: 'Alice Johnson',
        kemandoran: 'Mr. Z',
        subDivisi: 'Sub Divisi C',
      ),
    );

    tapperList.add(
      TapperModel(
        id: BigInt.from(4),
        nik: '321654987',
        name: 'Bob Brown',
        kemandoran: 'Mr. X',
        subDivisi: 'Sub Divisi A',
      ),
    );

    tapperList.add(
      TapperModel(
        id: BigInt.from(5),
        nik: '654321789',
        name: 'Charlie Green',
        kemandoran: 'Mr. Y',
        subDivisi: 'Sub Divisi B',
      ),
    );

    return tapperList;
  }
}
