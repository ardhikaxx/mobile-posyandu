class ApiConfig {
  static String apiUrl = 'http://192.168.100.171:4000';
  
  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }
  
  static String getApiUrl() {
    return apiUrl;
  }
}