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

var curTd=0;

var oldSort="";
var PIF_S="up";
var first=false;
var oldSel=0;
var oldK=0;
function goTab(type)
{
      curTd=0;
			oldSel=0;
			oldK=0;
      //document.all['TYPE'].value="";
			document.all['pifUp'].style.display='none';
			document.all['pifDw'].style.display='none';
			oldSel=0;
			
 if(type!=null)
 {
  if(first)
  {
	  if(document.all['kolTr'].value>0)
		{
    if(type=='inr')
		  {
	      if((PIF_S=="")||(PIF_S=="dw"))
				{
	        PIF_S="up";
	    		document.all['TYPE'].value="PIFup";
					document.all['pifDw'].style.display='';
	      }
		    else
				{
		  	  if(PIF_S=="up")
					{
			  	 	PIF_S="dw";
	      		document.all['TYPE'].value="PIFdw";
						document.all['pifUp'].style.display='';
			    }
		    }
	    }
	  document.all['frm1'].submit();}}
 }
 else
 {
  if(type==null)
	 {
	  //alert(document.all['R_T'][3].checked);
	  //if(document.all['RG_GROUP'][2].checked)
		//{
		  first=true;
		 // document.all['pifTd'].style.cursor='hand';
			document.all['first'].value="";
		//}
		//else
		//{
		  //alert();
		//  first=false;
		//  document.all['pifTd'].style.cursor='';

		//}
	  document.all['frm1'].submit();
	}
 }
}

function selTrSCH_VST(count_inp,COD_TR,k)
	{
	if (curTd!=0) {
		document.all["tr"+curTd+"_"+oldK].className="listTr";
		for (i=0; i<count_inp; i++) document.all['inp'+i+curTd+"_"+oldK].className="dataInput";
	}
	document.all["tr"+COD_TR+"_"+k].className="dataTrSelected";
	for (i=0; i<count_inp; i++)	 document.all['inp'+i+COD_TR+"_"+k].className="dataInputSelected";
  oldK=k;
	curTd=COD_TR;
	document.all['PARENT_ID'].value=document.all['PAR_ID'+COD_TR+"_"+k].value;
	document.all['_ID'].value=document.all['_ID'+COD_TR+"_"+k].value;
	ToolBar.Detail.setEnabled(true);
	}

function showDetailSCH_VST(){
  if(document.all['RG_TIP_RSO'][0].checked)	{
	  //alert('Under construction');
		result=window.showModalDialog('../Form_RSO_MAN/RSO_MAN_Form.jsp?ID_PARENT='+document.all['PARENT_ID'].value+'&ID='+document.all['_ID'].value,'','dialogHeight:500px;dialogwidth:900px;scroll:yes;status:no;help:no');
	}else{
	  result=window.showModalDialog('../Form_RSO_LUO_FSC/RSO_LUO_FSC_Form.jsp?ID_PARENT='+document.all['PARENT_ID'].value+'&ID='+document.all['_ID'].value,'','dialogHeight:530px;dialogwidth:800px;scroll:yes;status:no;help:no');
  }
}

function getLOV_RSO(){
	var obj=new Object();
	var tip_rso="";
	if(document.all['RG_TIP_RSO'][0].checked){
		tip_rso = 'M';
	}else if(document.all['RG_TIP_RSO'][1].checked){
		      tip_rso = 'L';
			  }else tip_rso = 'E';
	var url="Form_SCH_RIV_RSO/SCH_RIV_RSO_Lovs.jsp?LOCAL_MODE=LOV_RSO|TIP_RSO="+tip_rso+"|NOM_RSO="+document.all['NOM_RSO'].value+"|CLF_RSO="+document.all['CLF_RSO'].value+"|COD_AZL="+document.all['COD_AZL'].value;
	if(showSearch(url, obj)=="OK"){
		document.all['ifrmWork'].src="SCH_RIV_RSO_LovSet.jsp?ID="+obj.ID+"&LOCAL_MODE=LOV_RSO";		
	}
}
