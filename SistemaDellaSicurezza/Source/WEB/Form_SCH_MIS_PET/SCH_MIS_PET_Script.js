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

var sortDP="asc";
var curTd=0, curOpen=0;

function goTab(){
	document.all["imgDP"].style.display="none";
	document.all["SORT_DAT_PAR_ADT"].value="X";
	document.all["frmWork"].target="ifrmWork";
	document.all["frmWork"].submit();
	curOpen=1;
	sortDP="asc";
	curTd=0;
}

function sort_SCH_MIS_PET(nameColumn){
  if (curOpen!=2) return;
	if (nameColumn=="dp") {
		switch(sortDP){
			case "asc": 
				document.all["SORT_DAT_PAR_ADT"].value=", 'a'.'dat_pnz_mis_pet' desc ";
				document.all["imgDP"].src="../_images/ORDINE_UP.GIF";
				document.all["imgDP"].alt="up";
				document.all["imgDP"].style.display="";
				sortDP="desc";
				break;
			case "desc":
				document.all["SORT_DAT_PAR_ADT"].value=", 'a'.'dat_pnz_mis_pet' asc ";
				document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDP"].alt="down";
				document.all["imgDP"].style.display="";
				sortDP="asc"
				break;
			case "":
				document.all["SORT_DAT_PAR_ADT"].value=", 'a'.'dat_pnz_mis_pet' asc ";
				document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDP"].alt="down";
				document.all["imgDP"].style.display="";
				sortDP="asc"
                                alert("asc");
				break;
		}
	}
	document.all["frmWork"].submit();
}

function selTrSCH_MIS_PET(count_inp,COD_TR){
	if (curTd!=0) {
		document.all["tr"+curTd].className="listTr";
		for (i=1; i<=count_inp; i++) document.all['inp'+i+curTd].className="dataInput";
	}
	document.all["tr"+COD_TR].className="dataTrSelected";
	for (i=1; i<=count_inp; i++) document.all['inp'+i+COD_TR].className="dataInputSelected";
	curTd=COD_TR;
	ToolBar.Detail.setEnabled(true);
}

function showDetailSCH_MIS_PET(){
	if (document.all["NB_APL_A"][0].checked){
		 nCOD_MIS_RSO_LUO = document.all["nCOD_MIS_RSO_LUO"+curTd].value;
		 nCOD_RSO_LUO_FSC = document.all["nCOD_RSO_LUO_FSC"+curTd].value;
		 nCOD_LUO_FSC = document.all["nCOD_LUO_FSC"+curTd].value;
		 result=window.showModalDialog('../Form_MIS_PET_LUO_FSC/MIS_PET_LUO_FSC_Form.jsp?ID='+nCOD_MIS_RSO_LUO+'&ID_PARENT='+nCOD_RSO_LUO_FSC+'&COD_LUO_FSC='+nCOD_LUO_FSC,'','dialogHeight:710px;dialogwidth:900px;scroll:yes;status:no;help:no');
	}
	if (document.all["NB_APL_A"][1].checked){
		 nCOD_MIS_PET_MAN = document.all["nCOD_MIS_PET_MAN"+curTd].value;
		 nCOD_RSO_MAN = document.all["nCOD_RSO_MAN"+curTd].value;
		 nCOD_MAN = document.all["nCOD_MAN"+curTd].value;
		 result=window.showModalDialog('../Form_MIS_PET_MAN/MIS_PET_MAN_Form.jsp?ID='+nCOD_MIS_PET_MAN+'&ID_PARENT='+nCOD_RSO_MAN+'&COD_MAN='+nCOD_MAN,'','dialogHeight:540px;dialogwidth:900px;scroll:yes;status:no;help:no');
	}
}

function onMIS_PET_MAN_LUO_FSC(){
	document.all['COD_MIS_PET_LUO_MAN'].value = '0'; 
	document.all['NOM_MIS_PET_LUO_MAN'].value = ''; 
	document.all['COD_RSO'].value = '0'; 
	document.all['NOM_RSO'].value = ''; 
}
