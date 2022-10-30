import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:httpexplorer/models/site.dart';
import 'package:servicestack/client.dart';

class AppModel extends ChangeNotifier {
  String urlBarHint = "Domain, URL or Open API resource";
  TextEditingController txtUrlController = TextEditingController();
  String statusBarText = "";

  String appError = "";
  String appMessage = "";
  bool loading = false;

  String? currentSite;
  String? addingApiUrl;

  List<Site> sites = <Site>[
    Site("https://techstacks.io"),
    Site("https://techstacks2.com"),
    Site("http://a.very.longurlthat.shouldnot.error.com"),
  ];

  Future<bool> addSite(String site) async {
    if (site == "") return false;

    var apiUrl = !site.contains("://") ? "https://" + site : site;

    var existingSite = sites.any((x) => x.baseUrl == apiUrl);
    if (existingSite) {
      txtUrlController.text = "";
      return false;
    }

    var apiUri = Uri.tryParse(apiUrl);
    if (apiUri == null) {
      updateAppError("Not a valid URL!");
      return false;
    } else {
      updateAppError("");
    }

    addingApiUrl = apiUrl;
    var releaseLoading = updateLoading("Connecting to $apiUrl ...");

    try {
      var client = ClientFactory.create(apiUrl);
      var strResponse = await client.getAs("/", responseAs: TypeAs.string);
      if (addingApiUrl == apiUrl) {
        sites.add(Site(apiUrl));
        txtUrlController.text = "";
        return true;
      }
    } on WebServiceException catch (e) {
      if (addingApiUrl == apiUrl) {
        updateAppError("Could not connect to host");
      }
    } finally {
      releaseLoading(addingApiUrl == apiUrl);
    }
    return false;
  }

  Function updateStatusBar(String statusText) {
    var hold = statusBarText;
    statusBarText = statusText;
    super.notifyListeners();
    return () { updateStatusBar(hold); };
  }

  Function(bool reset) updateLoading(String loadingText) {
    appError = "";
    var holdLoading = loading;
    var holdText = appMessage;
    loading = true;
    appMessage = loadingText;
    super.notifyListeners();
    return (bool reset) {
      loading = reset ? false : holdLoading;
      appMessage = reset ? "" : holdText;
      super.notifyListeners();
    };
  }

  void updateAppError(String errorMsg) {
    appError = errorMsg;
    super.notifyListeners();
  }
}
