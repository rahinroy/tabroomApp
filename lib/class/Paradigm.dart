
import 'package:flutter/cupertino.dart';

import '../main.dart';

class Paradigm {
  var link;
  var para;
  var paraList = [];
  var format = [];
  Paradigm(tlink){
    link = tlink;
  }
  Future init() async {

    String formatType(outerTag) {
      var tag = outerTag;
      if (outerTag.length > 7) {
        tag = outerTag.substring(0, 7);
      }
      if (tag.contains("em")){
        return ("i");
      } else if (tag.contains("strong")){
        return ("b");
      } else if (tag.contains("span")){
        return ("s");
      } else {
        return ("n");
      }
    }

    if (link == ""){
      para = "";
      paraList.add(["No Paradigm Listed"]);
      format.add(["n"]);
    } else {
      para = "feifwinfe";
      var dom = await construct(link);
      var pg = dom.querySelectorAll("p");
      var temp;
      for (var x = 0; x < pg.length; x++){
        temp = "";
        if (pg[x].querySelectorAll("strong, span, em").length == 0){
          temp = removeTab(pg[x].text.trim());
          paraList.add([temp]);
          format.add(["n"]);
        } else {
          var tempEleList = pg[x].querySelectorAll("strong, span, em");
          var tempList = pg[x].text.trim().split(pg[x].querySelectorAll("strong, span, em")[0].text);
          var tempFormat = [];
          tempList.insert(1, pg[x].querySelectorAll("strong, span, em")[0].text.trim());
          tempFormat.addAll(["n", formatType(pg[x].querySelectorAll("strong, span, em")[0].outerHtml), "n"]);
          for (var y = 1; y < tempEleList.length; y++){
            var innerTempList = [];
            innerTempList = tempList[tempList.length - 1].split(pg[x].querySelectorAll("strong, span, em")[0].text);
            tempList[tempList.length - 1] = innerTempList[0];
            tempList.add(pg[x].querySelectorAll("strong, span, em")[0].text);
            tempList.add(innerTempList[0]);
            tempFormat.addAll(["n", formatType(pg[x].querySelectorAll("strong, span, em")[0].outerHtml), "n"]);
          }
          for (var z = 0; z < tempList.length; z++){
            tempList[z] = tempList[z].trim().replaceAll("\t", "").replaceAll("\n", "");
          }
          paraList.add(tempList);
          format.add(tempFormat);
        }
      }
    }
    for (var x = 0; x < paraList.length; x++){
      for (var y = 0; y < paraList[x].length; y++){
        if (y == paraList[x].length - 1){
          paraList[x][y] += "\n\n";
        }
      }
    }
    print (paraList);
    if (paraList.isEmpty){
      paraList.add(["No Paradigm Listed"]);
      format.add(["n"]);
    }
  }
}