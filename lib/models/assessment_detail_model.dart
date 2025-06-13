class AssessmentDetailModel {
  AssessmentDetailModel({
    required this.id,
    required this.assessmentCode,
    required this.nikPenyadap,
    required this.tanggalInspeksi,
    required this.inspectionBy,
    required this.task,
    required this.jenisKulitPohon,
    required this.panelSadap,
    required this.blok,
    required this.noHancak,
    required this.tahunTanam,
    required this.clone,
    required this.sistemSadap,
    required this.createdAt,
    this.foremanUploadAt,

  });
  final int id;
  final String assessmentCode;
  final String nikPenyadap;
  final String tanggalInspeksi;
  final String inspectionBy;
  final String task;
  final String jenisKulitPohon;
  final String panelSadap;
  final String blok;
  final String noHancak;
  final int tahunTanam;
  final String clone;
  final String sistemSadap;
  final String createdAt;
  final String? foremanUploadAt;

  factory AssessmentDetailModel.fromJson(Map<String, dynamic> json) {
    return AssessmentDetailModel(
      id: json['id'],
      assessmentCode: json['assessment_code'],
      nikPenyadap: json['nik_penyadap'],
      tanggalInspeksi: json['tanggal_inspeksi'],
      inspectionBy: json['inspection_by'],
      task: json['task'],
      jenisKulitPohon: json['jenis_kulit_pohon'],
      panelSadap: json['panel_sadap'],
      blok: json['blok'],
      noHancak: json['no_hancak'],
      tahunTanam: json['tahun_tanam'],
      clone: json['clone'],
      sistemSadap: json['sistem_sadap'],
      createdAt: json['created_at'],
      foremanUploadAt: json['foreman_upload_at'],
    );
  }
}