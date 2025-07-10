class BlockModel {
  BlockModel({
    required this.id,
    required this.blockName,
    required this.blockCode,
    required this.tahunTanam,
    this.clone,
  });

  final int id;
  final String blockName;
  final String blockCode;
  final int tahunTanam;
  final String? clone;

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      id: map['id'],
      blockName: map['block_name'],
      blockCode: map['block_code'],
      tahunTanam: map['tahun_tanam'],
      clone: map['clone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'block_name': blockName,
      'block_code': blockCode,
      'tahun_tanam': tahunTanam,
      'clone': clone,
    };
  }
}
