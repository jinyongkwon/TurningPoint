class Exerciselist {
  final String name, precautions, img, url;
  double difficulty;

  Exerciselist(
      {this.name, this.precautions, this.img, this.difficulty, this.url});
}

List<Exerciselist> exercises = [
  Exerciselist(
      name: "덤벨이두근운동",
      img: "assets/exercisephoto/biceps.jpg",
      precautions: "1. 덤벨을 잡을때 덤벨의 중간이 아닌 끝을 잡으셔야 합니다..\n\n"
          "2. 덤벨을 올리면서 손바닥이 바깥을 향하도록 회의시켜주세요.\n\n"
          "3. 팔꿈치는 몸에 붙인채 고정한채로 덤벨을 올렸다 내리면서 이완, 수축을 해주세요 ",
      difficulty: 3,
      url: 'hvyKIJ5T3cI'),
  Exerciselist(
      img: "assets/exercisephoto/squrt.jpg",
      name: "스쿼트",
      precautions: "1. 운동 시 복근에 힘을 줘서 중심을 유지시켜줍니다.\n\n"
          "2. 시선은 정면을 응시하고, 가슴을 펴고 허리를 아치형으로 가능한 곧게 펴줍니다.\n\n"
          "3. 내려갈 때 무릎이 발끝 앞으로 나오지 않도록 주의하면서 몸 안쪽이나 바깥쪽으로 나오지 않게 수평을 유지시켜 줍니다.\n\n"
          "4. 상체를 너무 굽히거나 중심을 뒤쪽에 두게 되면 허리 부상의 위험이 있으니 자세에 주의를 기울여야 합니다.",
      difficulty: 1,
      url: 'Fk9j6pQ6ej8'),
  Exerciselist(
      img: "assets/exercisephoto/flank.jpg",
      name: "플랭크",
      precautions: "1. 머리부터 발끝까지 일직선이 되어야 합니다.\n\n"
          "2. 복근에 자극이 가도록 자세를 유지해주세요.\n\n"
          "3. 어깨에 힘이 들어가지 않도록 주의해주세요.\n\n"
          "4. 엉덩이가 솟지않고 허리가 휘지 않아야 합니다.",
      difficulty: 5,
      url: 'B--6YfhmBGc'),
  Exerciselist(
      img: "assets/exercisephoto/pushup.jpg",
      name: "푸쉬업",
      precautions: "1. 엉덩이가 밑으로 내려앉거나 높이 들리지 않게 일직선이 되어야합니다.\n\n"
          "2.손바닥을 어깨 밑에 위치해야하며 손가락은 앞방향을 가리키고 있어야 합니다.\n\n"
          "3. 밑으로 내려갈때 복근과 엉덩이근육에 힘을 주면서 몸 전체가 아래로 내려올 수 있도록 합니다.",
      difficulty: 4,
      url: 'aoH7qNedO8k'),
];
