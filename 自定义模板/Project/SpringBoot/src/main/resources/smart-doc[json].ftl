{
  "serverUrl": "http://127.0.0.1:${jsonParam.port}${jsonParam.contextPath}",
  "outPath": "src/main/resources/static/doc/",
  "projectName": "${jsonParam.description!jsonParam.appName}",
  "style":"default",
  "createDebugPage": true,
  "showAuthor": false,
  "revisionLogs": [
    {
      "version": "1.0.0",
      "revisionTime": "${dateTime}",
      "status": "create",
      "author": "${paramConfig.author}",
      "remarks": "http://www.tablego.cn"
    }
  ]
}