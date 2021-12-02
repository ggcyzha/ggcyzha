(* ::Package:: *)

BeginPackage["nonabel`"];

ExpandNCM::usage="\:5728\:975e\:5bf9\:6613\:4e58\:6cd5\:540e\:52a0\:4e0a\:8fd9\:4e00\:9879\:ff0c\:6dfb\:52a0\:5206\:914d\:7387\:ff0c\:7528\:6cd5\:548c//Simplify\:4e00\:6837";
NToNA::usage="\:5728\:6b63\:5e38\:5199\:6cd5\:540e\:9762\:52a0\:4e0a\:8fd9\:4e00\:9879\:ff0c\:4f1a\:81ea\:52a8\:5c06\:5bf9\:6613\:4e58\:6cd5\:8f6c\:6362\:4e3a\:975e\:5bf9\:6613\:4e58\:6cd5\:ff0c\:5e76\:8fdb\:884c\:8fd0\:7b97\:ff0c\:6b64\:65f6\:5b9a\:4e49\:7684\:5e38\:6570\:5728\:975e\:5bf9\:6613\:4e58\:6cd5\:4e0b\:4efb\:7136\:6ee1\:8db3\:5bf9\:6613\:4e58\:6cd5\:5173\:7cfb"
KeepTimeToNonCommutativeMultiply::usage="\:7531\:4e8e\:8868\:8fbe\:5f0f\:5f88\:53ef\:80fd\:4e3a\:591a\:4e2a\:975e\:5bf9\:6613\:4e58\:6cd5\:5d4c\:5957\:ff0c\:7b97\:5b8c\:4e00\:5c42\:540e\:8981\:5c06\:6240\:6709\:7684\:5bf9\:6613\:4e58\:9879\:518d\:8f6c\:5316\:4e3a\:975e\:5bf9\:6613\:4e58\:ff0c\:8fd9\:6837ExpandNCM\:51fd\:6570\:624d\:53ef\:4ee5\:7ee7\:7eed\:5316\:7b80"
NCMToMM::="\:975e\:5bf9\:6613\:4e58\:6cd5\:8f6c\:6362\:4e3a\:77e9\:9635\:4e58\:6cd5"

Begin["`Private`"];
(*ExpandNCM\:51fd\:6570\:5b8c\:6210\:5bf9\:5355\:9879\:5f0f\:7684\:975e\:5bf9\:6613\:4e58\:6cd5\:7684\:5904\:7406\:ff0c\:5373Head\:5fc5\:987b\:4e3aNonCommutativeMultiply*)
ExpandNCM[(h:NonCommutativeMultiply)[a___,b_Plus,c___]]:=Distribute[h[a,b,c],Plus,h,Plus,ExpandNCM[h[##]]&];(*\:5206\:914d\:7387*)
ExpandNCM[a_]:=ExpandAll[a];(*\:4e00\:822c\:60c5\:51b5\:ff1a\:4e0d\:9700\:8981\:53d8\:6362*)
ExpandNCM[NonCommutativeMultiply[a_]]:=a;(*\:53d6\:6d88NonCommutativeMultiply\:5355\:5143\:8fd0\:7b97\:4e0d\:5316\:7b80\:7684\:6027\:8d28*)
ExpandNCM[NonCommutativeMultiply[]]:=1;(*\:975e\:5bf9\:6613\:4e58\:6cd5\:4e3a\:7a7a\:65f6\:4e3a1*)
MQ=#\[Element]Complexes||SubsetQ[Global`constant,Cases[#+1,_Symbol,Infinity]]&;(*\:5224\:65ad\:8868\:8fbe\:5f0f\:662f\:5426\:53ea\:5305\:542b\:590d\:6570\:6216\:5b9a\:4e49\:7684\:5e38\:6570*)
ExpandNCM[(h:NonCommutativeMultiply)[c___,a_?MQ,b___]]:=Times[a,ExpandNCM[h[c,b]]];(*\:5c06\:53ea\:5305\:542b\:5e38\:6570\:7684\:9879\:63d0\:51fa\:53d8\:4e3a\:5bf9\:6613\:4e58\:6cd5*)

KeepTimeToNonCommutativeMultiply=ToExpression[StringReplace[ToString[#//FullForm,OutputForm],{"Times"->"NonCommutativeMultiply"}]]&;(*\:4fdd\:8bc1\:975e\:5bf9\:6613\:4e58\:6cd5\:5d4c\:5957\:60c5\:51b5\:4e0b\:ff0c\:4e0a\:4e00\:5c42\:8f6c\:5316\:4e3a\:4e0b\:4e00\:5c42\:53ef\:4ee5\:4f7f\:7528\:7684\:7ed3\:679c*)
(*NToNA\:51fd\:6570\:5b8c\:6210\:5bf9\:5355\:9879\:5f0f\:ff0c\:591a\:9879\:5f0f\:ff0c\:5d4c\:5957\:ff0c\:76f8\:4e58\:7684\:975e\:5bf9\:6613\:4e58\:6cd5\:5904\:7406\:ff0c\:5373Head\:4e0d\:5fc5\:4e3aNonCommutativeMultiply*)
NToNA[X_]:=Module[{},tempp=StringReplace[ToString[X//FullForm,OutputForm],{"Times"->"NonCommutativeMultiply","Power"->"NonCommutativePower"}]//ToExpression;(*\:6240\:6709\:4e58\:6cd5\:66ff\:6362\:4e3a\:975e\:5bf9\:6613\:4e58\:6cd5\:ff0c\:6240\:6709\:6307\:6570\:8fd0\:7b97\:66ff\:6362\:4e3a\:975e\:5bf9\:6613\:6307\:6570\:8fd0\:7b97*)
tempp=StringReplace[ToString[tempp//FullForm,OutputForm],{"NonCommutativePower"->"Power"}]//ToExpression;(*\:5c06\:4e0d\:80fd\:5904\:7406\:7684\:6307\:6570\:8fd0\:7b97\:8fd8\:539f\:ff0c\:6bd4\:5982\:975e\:6b63\:6574\:6570\:ff0c\:8fd9\:4e9b\:4e00\:822c\:90fd\:662f\:5bf9\:6613\:5e38\:6570\:7684\:6307\:6570\:ff0c\:5f53\:7136\:53ef\:80fd\:5305\:542b\:9006\:5143\:ff0c\:6240\:4ee5\:8fd9\:4e2a\:7a0b\:5e8f\:8fd8\:4e0d\:80fd\:8ba1\:7b97\:9006\:5143\:7684\:975e\:5bf9\:6613\:4e58\:6cd5*)
tempp=StringReplace[ToString[tempp//FullForm,OutputForm],{"NonCommutativeMultiply"->"KeepTimeToNonCommutativeMultiply@ExpandNCM@NonCommutativeMultiply"}]//ToExpression;(*\:5bf9\:6240\:6709\:7684\:975e\:5bf9\:6613\:4e58\:6cd5\:8fdb\:884c\:4e00\:6b21\:8ba1\:7b97\:7ed3\:679c\:8f93\:51fa\:4e3a\:975e\:5bf9\:6613\:4e58\:6cd5\:5f62\:5f0f\:ff0c\:5b8c\:6210\:8fd9\:4e2a\:8fd0\:7b97\:540e\:7ed3\:679c\:4e3a\:5355\:9879\:5f0f\:975e\:5bf9\:6613\:4e58\:6cd5\:7684\:548c*)
tempp=StringReplace[ToString[tempp//FullForm,OutputForm],{"NonCommutativeMultiply"->"ExpandNCM@NonCommutativeMultiply"}]//ToExpression(*\:5c06\:975e\:5bf9\:6613\:4e58\:6cd5\:4e2d\:7684\:5bf9\:6613\:9879\:63d0\:51fa\:ff0c\:5373\:5b8c\:6210\:5355\:9879\:5f0f\:7684\:975e\:5bf9\:6613\:4e58\:6cd5\:5904\:7406*)
]

PIpositive=#\[Element]Integers&&#>1&(*\:5224\:65ad\:662f\:5426\:4e3a\:5927\:4e8e\:4e00\:7684\:6574\:6570*)
PI1=#==1&(*\:5224\:65ad\:662f\:5426\:4e3a1*)
NonCommutativePower[X_,n_?PIpositive]:=NonCommutativeMultiply[X,NonCommutativePower[X,n-1]];(*\:5b9a\:4e49\:975e\:5bf9\:6613\:6307\:6570\:8fd0\:7b97\:4e3a\:ff1an\:6b21\:65b9\:4e3an\:6b21\:975e\:5bf9\:6613\:4e58\:6cd5\:ff0cn\:53ea\:80fd\:53d6\:6b63\:6574\:6570\:ff0c\:5bf9\:4e8e\:9006\:5143\:8fd8\:672a\:5305\:62ec*)
NonCommutativePower[X_,n_?PI1]:=Expand[X];(*\:4e00\:6b21\:65b9\:4e3a\:81ea\:8eab*)

NCMToMM[X_]:=Module[{},StringReplace[ToString[X//FullForm,OutputForm],{"NonCommutativeMultiply"->"Dot"}]//ToExpression];


End[];
EndPackage[]
