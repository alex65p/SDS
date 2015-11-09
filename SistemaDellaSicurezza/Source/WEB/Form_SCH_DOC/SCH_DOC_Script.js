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

var sortDR="asc", sortTD="";
var curOpen=0;

function goTab(){
	document.all["imgDR"].style.display="none";
	document.all["imgTD"].style.display="none";
	ToolBar.Detail.setEnabled(false);
	document.all["frm1"].submit();
	curOpen=1;
	oldSel=0;
}

function goDOC()
{
  result=window.showModalDialog('../Form_ANA_DOC/ANA_DOC_Form.jsp?ID='+document.all["COD_DOC"].value,'','dialogHeight:760px;dialogwidth:680px;scroll:yes;status:no;help:no');
}


function sort_SCH_DOC(nameColumn){
  if (curOpen!=2)
	{
	  document.all["TDsortDR"].style.cursor='';
	  document.all["TDsortTD"].style.cursor='';
	 return;
	}
	document.all["TDsortDR"].style.cursor='hand';
	document.all["TDsortTD"].style.cursor='hand';
	if (nameColumn=="dr") {
		switch(sortDR){
			case "asc": 
				document.all["SORT_DAT_REV"].value=", 'a'.'dat_rev_doc' desc ";
				document.all["imgDR"].src="../_images/ORDINE_UP.GIF";
				document.all["imgDR"].alt="up";
				document.all["imgDR"].style.display="";
				sortDR="desc";
				break;
			case "desc":
				document.all["SORT_DAT_REV"].value=", 'a'.'dat_rev_doc' asc ";
				document.all["imgDR"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDR"].alt="down";
				document.all["imgDR"].style.display="";
				sortDR="asc"
				break;
			case "":
				document.all["SORT_DAT_REV"].value=", 'a'.'dat_rev_doc' asc ";
				document.all["imgDR"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgDR"].alt="down";
				document.all["imgDR"].style.display="";
				sortDR="asc"
				break;
		}
		sortTD="";
		document.all["SORT_TPL_DOC"].value="X";
		document.all["imgTD"].style.display="none";
	}
	if (nameColumn=="td") {
	switch(sortTD){
			case "asc": 
				document.all["SORT_TPL_DOC"].value=", 'b'.'nom_tpl_doc' desc ";
				document.all["imgTD"].src="../_images/ORDINE_UP.GIF";
				document.all["imgTD"].alt="up";
				document.all["imgTD"].style.display="";
				sortTD="desc";
				break;
			case "desc":
				document.all["SORT_TPL_DOC"].value=", 'b'.'nom_tpl_doc' asc ";
				document.all["imgTD"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgTD"].alt="down";
				document.all["imgTD"].style.display="";
				sortTD="asc"
				break;
			case "":
				document.all["SORT_TPL_DOC"].value=", 'b'.'nom_tpl_doc' asc ";
				document.all["imgTD"].src="../_images/ORDINE_DOWN.gif";
				document.all["imgTD"].alt="down";
				document.all["imgTD"].style.display="";
				sortTD="asc"
				break;
		}
		sortDR="";
		document.all["SORT_DAT_REV"].value="X";
		document.all["imgDR"].style.display="none";
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
