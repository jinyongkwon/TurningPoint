class Routinelist {
  final String name, precautions, img, url;
  double difficulty;

  Routinelist(
      {this.name, this.precautions, this.img, this.difficulty, this.url});
}

List<Routinelist> routines = [
  Routinelist(
      name: "전신운동 루틴",
      img: "assets/routinesphoto/routine1.jpg",
      precautions:
          "1. 푸쉬업을 하실때에는 몸 전체가 일직선으로 내려갔다가 올라와야하며 엉덩이가 많이 올라가거나, 내려가시면 카운트가 되지 않습니다.\n\n"
          "2. 스쿼트를 하실때에는 다리를 어깨 넓이 정도로 벌려주신뒤 무릎이 발끝을 넘어가지 않도록하고 무릎과 엉덩이가 일직선이 되어야 카운트가 됩니다.\n\n"
          "3. 플랭크를 하실떄에는 몸 전체가 일직선으로 되어야하며 엉덩이가 많이 올라가거나, 내려가시면 카운트가 되지 않습니다",
      difficulty: 3,
      url: 'UBVPNC1FBgc'),
];
