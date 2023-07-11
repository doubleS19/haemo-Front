enum PostType{
  meeting,
  club,
  hotPlace,
}

final postingTextField = [
  "제목을 입력해주세요",
];

final clubPostingTextField = [
  "제목을 입력해주세요",
  "소모임 소개내용을 입력해주세요",
  //"#해시태그를 입력해주세요"
];

final hotPlacePostingTextField = [
  "장소를 입력해주세요",
  "핫플에 대한 간단한 설명을 입력해주세요",
];

class Post {
  String appBarText;
  List<String> title;
  List<String> description;
  PostType type;
  String hintText;

  Post({
    required this.appBarText,
    required this.title,
    required this.description,
    required this.type,
    required this.hintText,
  });

  factory Post.fromType(PostType type) {
    String appBarText = '';
    List<String> title = [];
    List<String> description = [];
    String hintText = '';
    switch (type) {
      case PostType.hotPlace:
        appBarText = "핫플 등록";
        title = ["장소", "설명"];
        description = hotPlacePostingTextField;
        hintText = "핫플에 대한 내용을 입력해주세요";
        break;
      case PostType.meeting:
        appBarText = "모임 등록";
        title = ["모임"];
        description = postingTextField;
        hintText = "모임에 대한 내용을 입력해주세요";

        break;
      case PostType.club:
        appBarText = "소모임 등록";
        title = ["소모임", "설명"];
        description = clubPostingTextField;
        hintText = "소모임에 대한 내용을 입력해주세요";
        break;
    }

    return Post(
      appBarText: appBarText,
      title: title,
      description: description,
      type: type,
      hintText: hintText
    );
  }
}
