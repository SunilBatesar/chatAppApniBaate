class AppFunctions {
  static String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1-$user2";
    } else {
      return "$user2-$user1";
    }
  }
}
