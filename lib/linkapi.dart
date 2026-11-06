class Applink {
  // ================== static  ===============
  static const String server = "http://192.168.10.18:8000/api";
  static const String imageserver = "http://192.168.10.18:8000/";
  // ================== Auth  =================
  static const String login = "$server/login";
  static const String signup = "$server/register";
  static const String forgetpassword = "$server/forgot-password";
  static const String logout = "$server/";
  static const String verifycode = "$server/verify-reset-code";
  static const String resetpassword = "$server/reset-password";
  // ================= Home ====================
  static const String homepage = "$server/categories";
  static const String imagestatic = "$imageserver/storage/categories";
  static const String imagestaticplants = "$imageserver/storage";
  static const String searchCategories = "$server/categories?search=Vegetables";
   // ===== Favorites =====
  static const String favorites = "$server/favorites";             
  static const String favoritesAdd = "$server/favorites/add";       
  static const String favoritesRemove = "$server/favorites/remove";
}
