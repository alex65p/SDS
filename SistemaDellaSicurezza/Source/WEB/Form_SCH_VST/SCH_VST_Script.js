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

var sortDP="asc", sortDE="", sortT="", curType="m";
var curTd=0, curOpen=0, curNumSelTd=0;

function goTab(){
	document.all["imgDP"].style.display="none";
	document.all["imgDE"].style.display="none";
	document.all["imgT"].style.display="none";
	if (document.all["R_VISTA_V"].checked) {document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' asc "; curType="v";}
	if (document.all["R_VISTA_M"].checked) {document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_ido' asc "; curType="m";}
	document.all["SORT_DAT_EFT"].value="X";
	document.all["SORT_TPL_ACC"].value="X";
	document.all["frm1"].target="ifrmWork";
	ToolBar.Detail.setEnabled(false);
	document.all["frm1"].submit();
	curOpen=1;
	sortDP="asc"; sortDE=""; sortT="";
	curTd=0;curNumSelTd=0;
	
}

function sort_SCH_VST(nameColumn){
  if (curOpen!=2) return;
	if (nameColumn=="dp") {
		switch(sortDP){
			case "asc": 
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' desc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_PIF"].value=", , 'a'.'dat_pif_vst_ido' desc ";
				document.all["imgDP"].src="../_images/ORDINE_UP.GIF";
				document.all["imgDP"].alt="up";
				document.all["imgDP"].style.display="";
				sortDP="desc";
				break;
			case "desc":
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' asc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_PIF"].value=", , 'a'.'dat_pif_vst_ido' asc ";
				document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDP"].alt="down";
				document.all["imgDP"].style.display="";
				sortDP="asc"
				break;
			case "":
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' asc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_PIF"].value=", , 'a'.'dat_pif_vst_ido' asc ";
				document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDP"].alt="down";
				document.all["imgDP"].style.display="";
				sortDP="asc"
				break;
		}
		sortDE="";
		sortT="";
		document.all["SORT_DAT_EFT"].value="X";
		document.all["SORT_TPL_ACC"].value="X";
		document.all["imgDE"].style.display="none";
		document.all["imgT"].style.display="none";
		document.all["imgDE"].src="../_images/ORDINE_DOWN.gif";
		document.all["imgT"].src="../_images/ORDINE_DOWN.gif";
	}
	if (nameColumn=="de") {
		switch(sortDE){
			case "asc": 
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_med' desc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_ido' desc ";
				document.all["imgDE"].src="../_images/ORDINE_UP.GIF";
				document.all["imgDE"].alt="up";
				document.all["imgDE"].style.display="";
				sortDE="desc";
				break;
			case "desc":
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_med' asc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_ido' asc ";
				document.all["imgDE"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDE"].alt="down";
				document.all["imgDE"].style.display="";
				sortDE="asc"
				break;
			case "":
				if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_med' asc ";
				if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_EFT"].value=", 'a'.'dat_eft_vst_ido' asc ";
				document.all["imgDE"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDE"].alt="down";
				document.all["imgDE"].style.display="";
				sortDE="asc"
				break;
		}
		sortDP="";
		sortT="";
		document.all["SORT_DAT_PIF"].value="X";
		document.all["SORT_TPL_ACC"].value="X";
		document.all["imgDP"].style.display="none";
		document.all["imgT"].style.display="none";
		document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
		document.all["imgT"].src="../_images/ORDINE_DOWN.gif";
	}
	if (nameColumn=="t") {
		switch(sortT){
			case "asc": 
				document.all["SORT_TPL_ACC"].value=", 'a'.'tpl_acr_vlu_rso' desc ";
				document.all["imgT"].src="../_images/ORDINE_UP.GIF";
				document.all["imgT"].alt="up";
				document.all["imgT"].style.display="";
				sortT="desc";
				break;
			case "desc":
				document.all["SORT_TPL_ACC"].value=", 'a'.'tpl_acr_vlu_rso' asc ";
				document.all["imgT"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgT"].alt="down";
				document.all["imgT"].style.display="";
				sortT="asc"
				break;
			case "":
				document.all["SORT_TPL_ACC"].value=", 'a'.'tpl_acr_vlu_rso' asc ";
				document.all["imgT"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDE"].alt="down";
				document.all["imgT"].style.display="";
				sortT="asc"
				break;
		}
		sortDE="";
		sortDP="";
		document.all["SORT_DAT_PIF"].value="X";
		document.all["SORT_DAT_EFT"].value="X";
		document.all["imgDE"].style.display="none";
		document.all["imgDP"].style.display="none";
		document.all["imgDP"].src="../_images/ORDINE_DOWN.gif";
		document.all["imgDE"].src="../_images/ORDINE_DOWN.gif";
	}
	document.all["frm1"].submit();
}

function selTrSCH_VST(count_inp,numRec,COD_TR){
//alert(curNumSelTd+"==="+curNumSelTd);
	if (curNumSelTd!=0) {
		document.all["tr"+curNumSelTd].className="listTr";
		for (i=1; i<=count_inp; i++) document.all['inp'+i+curNumSelTd].className="dataInput";
	}
	document.all["tr"+numRec].className="dataTrSelected";
	for (i=1; i<=count_inp; i++) document.all['inp'+i+numRec].className="dataInputSelected";
	curNumSelTd=numRec;
	curTd=COD_TR;
	ToolBar.Detail.setEnabled(true);
}

function showDetailSCH_VST(){
	//if (document.all["R_VISTA_V"].checked)
	if (curType=="v"){
	result=window.showModalDialog('../Form_ANA_VST_MED/ANA_VST_MED_Form.jsp?ID='+curTd,'','dialogHeight:300px;dialogwidth:900px;scroll:yes;status:no;help:no');
	}
	//if (document.all["R_VISTA_M"].checked)
	if (curType=="m"){
	result=window.showModalDialog('../Form_ANA_VST_IDO/ANA_VST_IDO_Form.jsp?ID='+curTd,'','dialogHeight:20;dialogwidth:55;scroll:yes;status:no;help:no');
	}
}

function cambiParamSort(){
	if (document.all["R_VISTA_V"].checked) {document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' asc "; curType="v";}
	if (document.all["R_VISTA_M"].checked) {document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_ido' asc "; curType="m";}

	/*if (document.all["R_VISTA_V"].checked) document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_med' desc ";
	if (document.all["R_VISTA_M"].checked) document.all["SORT_DAT_PIF"].value=", 'a'.'dat_pif_vst_ido' desc ";

	document.all["SORT_DAT_EFT"].value="X";
	document.all["SORT_TPL_ACC"].value="X";
	curTd=0;curNumSelTd=0;*/
}
