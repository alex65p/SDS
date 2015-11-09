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

var sortDR="";
var curOpen=0;

function getLOV_MIS_PET(){
	var obj=new Object();
	var apl_a;
	if(document.all['NB_APL_A'][0].checked)
		apl_a = 'M';
	else
		apl_a = 'L';
		
	var url="Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_Lovs.jsp?LOCAL_MODE=LOV_MIS_PET|APL_A="+apl_a;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_MIS_PET_AZL_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_MIS_PET&APL_A="+apl_a;		
	}
}

function getLOV_MIS_PET_MAN_LUO_FSC(){
	var obj=new Object();
	if(document.all['NB_APL_A'][1].checked){
		var url="Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_Lovs.jsp?LOCAL_MODE=LOV_MIS_PET_MAN|COD_AZL="+document.all['COD_AZL'].value;
		if(showSearch(url, obj)=="OK"){
			document.all['ifrmWork'].src="SCH_MIS_PET_AZL_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_MIS_PET_MAN";		
		}
	}
	else{
		var url="Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_Lovs.jsp?LOCAL_MODE=LOV_MIS_PET_LUO_FSC|COD_AZL="+document.all['COD_AZL'].value;
		if(showSearch(url, obj)=="OK"){
			document.all['ifrmWork'].src="SCH_MIS_PET_AZL_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_MIS_PET_LUO_FSC";		
		}
	}
}

function getLOV_NOM_RSO(){
	var obj=new Object();
	var apl_a;
	if(document.all['NB_APL_A'][0].checked)
		apl_a = 'M';
	else
		apl_a = 'L';
		
	var url="Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_Lovs.jsp?LOCAL_MODE=LOV_NOM_RSO|APL_A="+apl_a+"|COD_MIS_PET_LUO_MAN="+document.all['NB_COD_MIS_PET_LUO_MAN'].value+"|COD_AZL="+document.all['COD_AZL'].value;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_MIS_PET_AZL_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_NOM_RSO";		
	}
}

function onMIS_PET_MAN_LUO_FSC(){
	document.all['NB_COD_MIS_PET_LUO_MAN'].value = '0'; 
	document.all['NB_NOM_MIS_PET_LUO_MAN'].value = ''; 
	document.all['NB_COD_RSO'].value = '0'; 
	document.all['NB_NOM_RSO'].value = ''; 
}

function goTab(){
	document.all["VAR_PAR_ADT"].value="X";
	document.all["frm1"].submit();
	document.all["imgDR"].style.display="none";
	curOpen=1;
        sortDR="asc";
	oldSel=0;
}

function goMIS_PET_AZL()
{
  result=window.showModalDialog('../Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Form.jsp?ID='+document.all["COD_MIS_PET_AZL"].value,'','dialogHeight:40;dialogwidth:55;scroll:yes;status:no;help:no');
//  result=window.open('../Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_Form.jsp?ID='+document.all["COD_MIS_PET_AZL"].value,'','dialogHeight:40;dialogwidth:55;scroll:yes;status:no;help:no');
}

function sort_SCH_MIS_PET_AZL(nameColumn){
  if (curOpen!=2) return;
	if (nameColumn=="dr") {
		switch(sortDR){
			case "asc": 
				document.all["VAR_PAR_ADT"].value=" desc ";
				document.all["imgDR"].src="../_images/ORDINE_UP.GIF";
				document.all["imgDR"].alt="up";
				document.all["imgDR"].style.display="";
				sortDR="desc";
				break;
                                
			case "desc":
				document.all["VAR_PAR_ADT"].value=" asc ";
				document.all["imgDR"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDR"].alt="down";
				document.all["imgDR"].style.display="";
				sortDR="asc";
				break;
                                
			case "":
				document.all["VAR_PAR_ADT"].value=" asc ";
				document.all["imgDR"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDR"].alt="down";
				document.all["imgDR"].style.display="";
				sortDR="asc";
				break;
		}
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

