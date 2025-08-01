using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Communications;

class GarminTodotxtWidgetApp extends App.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state) {
    makeRequest();
  }

  function onStop(state) {}

  function getInitialView() {
    return [new GarminTodotxtWidgetView([])];
  }

  function onReceive(responseCode, data) {
    // Expecting data to be an array of objects with 'id' and 'todo'
    var todos = [];
    if (data != null && data.size() > 0) {
      for (var i = 0; i < data.size(); ++i) {
        var item = data[i];
        todos.add(item.get("todo"));
      }
    }
    Ui.switchToView(
      new GarminTodotxtWidgetView(todos),
      null,
      Ui.SLIDE_IMMEDIATE
    );
  }

  function makeRequest() {
    var apiEndpoint = App.Properties.getValue("apiEndpoint");
    var apiKey = App.Properties.getValue("apiKey");

    var params = null;
    var options = {
      :method => Communications.HTTP_REQUEST_METHOD_GET,
      :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
      :headers => { "X-API-Key" => apiKey },
    };

    Communications.makeWebRequest(
      apiEndpoint,
      params,
      options,
      method(:onReceive)
    );
  }
}
