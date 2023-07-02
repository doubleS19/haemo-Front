enum PostType{
  meeting,
  club,
  hotPlace,
}

final postingTextField = [
  "제목을 입력해주세요",
  "모임에 대한 내용을 입력해주세요",
];

final clubPostingTextField = [
  "제목을 입력해주세요",
  "소모임 소개내용을 입력해주세요",
  "#해시태그를 입력해주세요",
  "소모임에 대한 내용을 입력해주세요"
];

final hotPlacePostingTextField = [
  "장소를 입력해주세요",
  "핫플에 대한 간단한 설명을 입력해주세요",
  "핫플에 대해 내용을 입력해주세요",
];

class Post {
  String appBarText;
  List<String> title;
  List<String> description;
  PostType type;

  Post({
    required this.appBarText,
    required this.title,
    required this.description,
    required this.type,
  });

  factory Post.fromType(PostType type) {
    String appBarText = '';
    List<String> title = [];
    List<String> description = [];

    switch (type) {
      case PostType.meeting:
        appBarText = "핫플 등록";
        title = ["장소", "설명"];
        description = postingTextField;
        break;
      case PostType.club:
        appBarText = "모임 등록";
        title = ["모임"];
        description = clubPostingTextField;
        break;
      case PostType.hotPlace:
        appBarText = "소모임 등록";
        title = ["소모임", "설명"];
        description = hotPlacePostingTextField;
        break;
    }

    return Post(
      appBarText: appBarText,
      title: title,
      description: description,
      type: type,
    );
  }
}
