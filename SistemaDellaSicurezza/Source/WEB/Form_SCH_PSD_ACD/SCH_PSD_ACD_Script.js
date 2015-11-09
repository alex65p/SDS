/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

var sortPIF="desc", sortINT="", sortRSP="";
var curOpen=0;

function goTab(){
	document.all["imgPIF"].style.display="none";
	document.all["imgINT"].style.display="none";
	document.all["imgRSP"].style.display="none";
	ToolBar.Detail.setEnabled(false);
	document.all["frm1"].submit();
	curOpen=1;
	oldSel=0;
}

function goDOC()
{
  result=window.showModalDialog('../Form_ANA_PSD_ACD/ANA_PSD_ACD_Form.jsp?ID='+document.all["COD_PSD_ACD"].value,'','dialogHeight:30;dialogwidth:50;scroll:yes;status:no;help:no');
}


function sort_SCH_PSD_ACD(nameColumn){
  if (curOpen!=2) 
		{
	  document.all["TDsortPIF"].style.cursor='';
	  document.all["TDsortINT"].style.cursor='';
	  document.all["TDsortRSP"].style.cursor='';
	 return;
	}
	document.all["TDsortPIF"].style.cursor='hand';
	document.all["TDsortINT"].style.cursor='hand';
	document.all["TDsortRSP"].style.cursor='hand';
	if (nameColumn=="pif") {
		switch(sortPIF){
			case "asc": 
				document.all["SORT_PIF"].value=", 'a'.'dat_pif_inr' desc ";
				document.all["imgPIF"].src="../_images/ORDINE_UP.GIF";
				document.all["imgPIF"].alt="up";
				document.all["imgPIF"].style.display="";
				sortPIF="desc";
				break;
			case "desc":
				document.all["SORT_PIF"].value=", 'a'.'dat_pif_inr' asc ";
				document.all["imgPIF"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgPIF"].alt="down";
				document.all["imgPIF"].style.display="";
				sortPIF="asc"
				break;
			case "":
				document.all["SORT_PIF"].value=", 'a'.'dat_pif_inr' asc ";
				document.all["imgPIF"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgPIF"].alt="down";
				document.all["imgPIF"].style.display="";
				sortPIF="asc"
				break;
		}
		sortINT="";
		sortRSP="";
		document.all["SORT_INT"].value="X";
		document.all["SORT_RSP"].value="X";
		document.all["imgINT"].style.display="none";
		document.all["imgRSP"].style.display="none";
	}
	if (nameColumn=="int") {
	switch(sortINT){
			case "asc": 
				document.all["SORT_INT"].value=", 'a'.'dat_inr' desc ";
				document.all["imgINT"].src="../_images/ORDINE_UP.GIF";
				document.all["imgINT"].alt="up";
				document.all["imgINT"].style.display="";
				sortINT="desc";
				break;
			case "desc":
				document.all["SORT_INT"].value=", 'a'.'dat_inr' asc ";
				document.all["imgINT"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgINT"].alt="down";
				document.all["imgINT"].style.display="";
				sortINT="asc"
				break;
			case "":
				document.all["SORT_INT"].value=", 'a'.'dat_inr' asc ";
				document.all["imgINT"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgINT"].alt="down";
				document.all["imgINT"].style.display="";
				sortINT="asc"
				break;
		}
		sortPIF="";
		sortRSP="";
		document.all["SORT_PIF"].value="X";
		document.all["SORT_RSP"].value="X";
		document.all["imgPIF"].style.display="none";
		document.all["imgRSP"].style.display="none";
	}
	if (nameColumn=="rsp") {
	switch(sortRSP){
			case "asc": 
				document.all["SORT_RSP"].value=", 'a'.'nom_rsp_inr' desc ";
				document.all["imgRSP"].src="../_images/ORDINE_UP.GIF";
				document.all["imgRSP"].alt="up";
				document.all["imgRSP"].style.display="";
				sortRSP="desc";
				break;
			case "desc":
				document.all["SORT_RSP"].value=", 'a'.'nom_rsp_inr' asc ";
				document.all["imgRSP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgRSP"].alt="down";
				document.all["imgRSP"].style.display="";
				sortRSP="asc"
				break;
			case "":
				document.all["SORT_RSP"].value=", 'a'.'nom_rsp_inr' asc ";
				document.all["imgRSP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgRSP"].alt="down";
				document.all["imgRSP"].style.display="";
				sortRSP="asc"
				break;
		}
		sortPIF="";
		sortINT="";
		document.all["SORT_PIF"].value="X";
		document.all["SORT_INT"].value="X";
		document.all["imgPIF"].style.display="none";
		document.all["imgINT"].style.display="none";
	}

	document.all["frm1"].submit();
}

var oldSel=0;
function selTabStr(theId, kolInp, obj)
{ 
  if (oldSel!=0)
	{ 
	  document.all["tr"+oldSel].className="listTr";
		for(i=1;i<=kolInp;i++)
		{
		  document.all['inp'+i+oldSel].className="dataInput";
		}
	}
	document.all["tr"+theId].className="dataTrSelected";
	for(i=1;i<=kolInp;i++)
	{
		document.all['inp'+i+theId].className="dataInputSelected";
	}
  oldSel=theId;
	document.all[obj].value=theId;
	ToolBar.Detail.setEnabled(true);
}
function getLOV_CAG(){
	var obj=new Object();
	var url="Form_SCH_PSD_ACD/SCH_PSD_ACD_Lovs.jsp?LOCAL_MODE=LOV_CAG|NOM_CAG_PSD_ACD="+document.all['NB_NOM_CAG_PSD_ACD'].value+"|COD_AZL="+document.all['COD_AZL'].value;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_PSD_ACD_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_CAG";		
	}
}
function getLOV_PSD(){
	var obj=new Object();
	var url="Form_SCH_PSD_ACD/SCH_PSD_ACD_Lovs.jsp?LOCAL_MODE=LOV_PSD|NOM_CAG_PSD_ACD="+document.all['NB_NOM_CAG_PSD_ACD'].value+"|IDE_PSD_ACD="+document.all['NB_IDE_PSD_ACD'].value+"|COD_PSD_ACD="+document.all['COD_PSD_ACD'].value+"|COD_CAG_PSD_ACD="+document.all['COD_CAG_PSD_ACD'].value+"|COD_AZL="+document.all['COD_AZL'].value;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_PSD_ACD_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_PSD";		
	}
}
function getLOV_DPD(){
	var obj=new Object();
	var url="Form_SCH_PSD_ACD/SCH_PSD_ACD_Lovs.jsp?LOCAL_MODE=LOV_DPD|COD_PSD_ACD="+document.all['COD_PSD_ACD'].value+"|COD_AZL="+document.all['COD_AZL'].value;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_PSD_ACD_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_DPD";		
	}
}
