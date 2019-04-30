

class UserEntity{

  /**
   * verified_content :
   * avatar_url : http://p3.pstatp.com/thumb/216b000e0abb3ee9cb91
   * user_id : 59834611934
   * name : 电竞手游君
   * follower_count : 0
   * follow : false
   * user_auth_info :
   * user_verified : false
   * description : 游戏 资讯 游戏攻略 你要的这里都有，来这里就对了。
   */

  String verified_content;
  String avatar_url;
  int user_id;
  String name;
  int follower_count;
  bool follow;
  String user_auth_info;
  bool user_verified;
  String description;

  UserEntity({
    this.verified_content, this.avatar_url, this.user_id, this.name,
    this.follower_count, this.follow, this.user_auth_info, this.user_verified,
    this.description
});

  static UserEntity fromJson(Map<String,dynamic> json){
    UserEntity userEntity = UserEntity(
      verified_content: json['verified_content'],
      avatar_url: json['avatar_url'],
      user_id: json['user_id'],
      name: json['name'],
      follower_count: json['follower_count'],
      follow: json['follow'],
      user_verified: json['user_verified'],
      user_auth_info: json['user_auth_info'],
      description: json['description']
    );
    return userEntity;
  }

  Map<String,dynamic> toJson() =>{
  'verified_content':verified_content,
  'avatar_url':avatar_url,
  'user_id' : user_id,
    'name' : name,
  'follower_count' : follower_count,
    'follow' : follow,
  'user_verified' : user_verified,
  'user_auth_info':user_auth_info,
  'description':description
  };


}















