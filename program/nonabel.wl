(* ::Package:: *)

BeginPackage["nonabel`"];

ExpandNCM::usage="\:5728\:975e\:5bf9\:6613\:4e58\:6cd5\:540e\:52a0\:4e0a\:8fd9\:4e00\:9879\:ff0c\:6dfb\:52a0\:5206\:914d\:7387\:ff0c\:7528\:6cd5\:548c//Simplify\:4e00\:6837";
NToNA::usage="\:5728\:6b63\:5e38\:5199\:6cd5\:540e\:9762\:52a0\:4e0a\:8fd9\:4e00\:9879"

Begin["`Private`"];
ExpandNCM[(h:NonCommutativeMultiply)[a___,b_Plus,c___]]:=Distribute[h[a,b,c],Plus,h,Plus,ExpandNCM[h[##]]&];
ExpandNCM[a_]:=ExpandAll[a];
MQ=MemberQ[Global`constant&&Complexes,#]&;
ExpandNCM[NonCommutativeMultiply[c___,a_?MQ,b___]]:=Times[a,NonCommutativeMultiply[c,b]];
NToNA[X_]:=X//.{A_^n_->A**A^(n-1)}//.{A_*B_->A**B};




End[];
EndPackage[]
