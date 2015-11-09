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

var oldSort="";
var INR_S="up";
var ADT_S="";
var first=false;
var oldSel=0;
function goTab(type)
{
			document.all['adtUp'].style.display='none';
			document.all['adtDw'].style.display='none';
			document.all['pifUp'].style.display='none';
			document.all['pifDw'].style.display='none';
			//document.all['pifTd'].style.cursor='';
		  //document.all['adtTd'].style.cursor='';
			ToolBar.Detail.setEnabled(false);
			oldSel=0;

 if(type!=null)
 {
  if(first)
  {
	  if(document.all['kolTr'].value>0)
		{
    if(type=='inr')
		  {
	      if((INR_S=="")||(INR_S=="dw"))
				{
	        INR_S="up";
	    		document.all['TYPE'].value="INRup";
					document.all['pifDw'].style.display='';
	      }
		    else
				{
		  	  if(INR_S=="up")
					{
			  	 	INR_S="dw";
	      		document.all['TYPE'].value="INRdw";
						document.all['pifUp'].style.display='';
			    }
		    }
	    }
	  else
		{
	    if(type=='adt')
		  {
		    if((ADT_S=="")||(ADT_S=="dw"))
		    {
		     ADT_S="up";
	       document.all['TYPE'].value="ADTup";
			   document.all['adtDw'].style.display='';
	      }
		    else
		    {
		     if(ADT_S=="up")
			    {
			      ADT_S="dw";
	          document.all['TYPE'].value="ADTdw";
						document.all['adtUp'].style.display='';
			    }
		    }
	    }
		
	 }document.all['FormParams'].submit();}}
 }
 else
 {
  if(type==null)
	 {
	  //alert(document.all['R_T'][3].checked);
	  //if(document.all['R_T'][3].checked)
		//{
		  //alert(document.all['R_T'][3].checked);
			//if(document.all['kolTr'].value>0)
		//{
		  first=true;
			document.all['first'].value="";
		//}
		//}
		//else
		//{
		  //alert();
		//  first=false;
		//  document.all['pifTd'].style.cursor='';
	//	  document.all['adtTd'].style.cursor='';

		//}
	  document.all['FormParams'].submit();
	}
 }
}
function changeMIS_PET_LUO(VAL){
  //var obj=document.all["ORGANIZZATIVA"];

    if(VAL=="M")
	{
	  document.all["ifrmWork"].src="SCH_INR_ADT_SelChange.jsp?TYPE=MIS_MAN&AZIENDA="+document.all['COD_AZL'].value;
	}
	else{
	  if(VAL=="L"){document.all["ifrmWork"].src="SCH_INR_ADT_SelChange.jsp?TYPE=LUO_MIS&AZIENDA="+document.all['COD_AZL'].value;}
	}
}


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
	//alert(theId.substring(3,theId.length-1));
	//alert(obj);
	document.all[obj].value=theId;
	ToolBar.Detail.setEnabled(true);
}

function goINR_ADT()
{
  result=window.showModalDialog('../Form_ANA_INR_ADT/ANA_INR_ADT_Form.jsp?ID='+document.all["COD_ADT"].value,'','dialogHeight:700px;dialogwidth:900px;scroll:yes;status:no;help:no');
}
