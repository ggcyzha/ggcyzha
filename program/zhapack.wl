(* ::Package:: *)

BeginPackage["zhapack`"];

LookDiv::usage="\:5bfb\:627e\:53d1\:6563\:9879LookDiv[A_,u_,number_,v___]=LookDiv[target,variable,point,(Assumptions&&...\:53ef\:4ee5\:7f3a\:7701)]";
SumLookDiv4::usage="\:53d1\:6563\:9879\:7684\:8868\:8fbe\:5f0fSumLookDiv[A_,u_,number_,v___]=Sum[LookDiv[[4,i]]]";
Summ::usage="Summ[A_]:=Sum[A[[i]],{i,Length[A]}]";
LookLim::usage="\:9010\:9879\:6c42\:5bfc\:6570LookLim[A_(\:76ee\:6807),u_\:ff08\:53d8\:91cf\:ff09,number_\:ff08\:70b9\:ff09,v___\:ff08\:53d8\:91cf\:7ea6\:675f\:6761\:4ef6\:ff0c\:53ef\:7f3a\:7701\:ff09]";
ReDivrule::usage="\:5254\:9664\:53d1\:6563\:7684\:89c4\:5219";
Solverule::usage="\:96c6\:6210\:5316\:89e3\:65b9\:7a0b";

Begin["`Private`"];

LookDiv[A_,u_,number_,v___]:=Module[{},
B=A//ExpandAll;
H=Length[B];
k1=0;
k2=0;
Do[Global`rate=i/H//N;If[StringMatchQ[Refine[Limit[B[[i]],u->number],v]//ToString,"Indeterminate"],
k1=k1+1;f1[k1]=B[[i]];,
If[StringMatchQ[Refine[Limit[B[[i]],u->number],v]//ToString,___~~"Infinity"~~___],
k2=k2+1;f2[k2]=B[[i]];
]
]
,{i,H}];
B1=Array[b1,k1];
Do[B1[[i]]=f1[i];
,{i,k1}];
B2=Array[b2,k2];
Do[B2[[i]]=f2[i];
,{i,k2}];
CC={{"Indeterminate"},B1,{"Infinity"},B2};
;CC];

SumLookDiv4[A_,u_,number_,v___]:=Sum[LookDiv[A,u,number,v][[4,i]],{i,Length[LookDiv[A,u,number,v][[4]]]}];

Summ[A_]:=Sum[A[[i]],{i,Length[A]}];

LookLim[A_,u_,number_,v___]:=Module[{},
temp=A//Expand;
len=Length[temp];
Clear[B];
B=Array[b,{len}];
Do[Global`rate=i/len//N;B[[i]]=Refine[Limit[temp[[i]],u->number],v],{i,len}];
B];

ReDivrule[A_,x_,CC_,B_,v___]:=Module[{},
temp=LookDiv[A,x,B,v];
temp=Summ[Union[temp[[2]],temp[[4]]]];
temp=Solve[Refine[temp,v]==0,CC][[1]];
temp=Refine[Limit[CC/.temp,x->B],v];
{CC->temp}
];

Solverule[A_,CC_,B_,v___]:=Module[{},
temp=Solve[Refine[A,v],CC][[1]];
temp=Refine[Limit[CC/.temp,B],v];
{CC->temp}
];


End[];
EndPackage[]
