class ResultResponseDto {
  final String? predictedGender;
  final String? predictedJob1;
  final String? predictedJob2;
  final String? predictedJob3;
  final String? predictedJob1Image;
  final String? predictedJob2Image;
  final String? predictedJob3Image;

  ResultResponseDto(this.predictedGender, this.predictedJob1, this.predictedJob2, this.predictedJob3, this.predictedJob1Image, this.predictedJob2Image, this.predictedJob3Image);

  ResultResponseDto.fromJson(Map<String, dynamic> json)
      : predictedGender = json["predicted_gender"],
        predictedJob1 = json["predicted_job1"],
        predictedJob2 = json["predicted_job2"],
        predictedJob3 = json["predicted_job3"],
        predictedJob1Image = json["predicted_job1_image"],
        predictedJob2Image = json["predicted_job2_image"],
        predictedJob3Image = json["predicted_job3_image"];

}