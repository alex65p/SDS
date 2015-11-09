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

//function goTab(){
//	document.all["frm1"].submit();
//}
var oldSel=0;
var oldK=0;
var INR_S="up";
var EFT_S="";
var first=false;
function goTab(type)
{
	document.all['eftUp'].style.display='none';
	document.all['eftDw'].style.display='none';
	document.all['pifUp'].style.display='none';
	document.all['pifDw'].style.display='none';
	ToolBar.Detail.setEnabled(false);
	oldSel=0;
	oldK=0;
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
	    if(type=='eft')
		  {
		    if((EFT_S=="")||(EFT_S=="dw"))
		    {
		     EFT_S="up";
	       document.all['TYPE'].value="EFTup";
			   document.all['eftDw'].style.display='';
	      }
		    else
		    {
		     if(EFT_S=="up")
			    {
			      EFT_S="dw";
	          document.all['TYPE'].value="EFTdw";
						document.all['eftUp'].style.display='';
			    }
		    }
	    }
		
	 }document.all['frm1'].submit();}}
 }
 else
 {
  if(type==null)
	 {
	  //alert(document.all['R_T'][3].checked);
	  /*if(document.all['R_RAGGRUPPATI'][3].checked)
		{*/
		  //alert(document.all['R_T'][3].checked);
		  first=true;
			document.all['first'].value="";
		/*  document.all['pifTd'].style.cursor='hand';
		  document.all['eftTd'].style.cursor='hand';
			
		}
		else
		{
		  //alert();
		  first=false;
		  document.all['pifTd'].style.cursor='';
		  document.all['eftTd'].style.cursor='';
		
		}*/
	  document.all['frm1'].submit();
	}
 }
}


function selTabStr(theId, kolInp, obj, k)
{
  if (oldSel!=0)
	{ 
	  document.all["tr"+oldSel+"_"+oldK].className="listTr";
		for(i=1;i<=kolInp;i++)
		{
		  document.all['inp'+i+oldSel+"_"+oldK].className="dataInput";
		}
	}
	document.all["tr"+theId+"_"+k].className="dataTrSelected";
	for(i=1;i<=kolInp;i++)
	{
		document.all['inp'+i+theId+"_"+k].className="dataInputSelected";
	}
  oldSel=theId;
	oldK=k;
	//alert(theId.substring(3,theId.length-1));
	//alert(obj);
  document.all[obj].value=theId;
	ToolBar.Detail.setEnabled(true);
}

function goEGZ_COR()
{
  result=window.showModalDialog('../Form_SCH_INR_DPI/SCH_INR_DPI_Form.jsp?ID='+document.all["COD_SCH_INR_DPI"].value,'','dialogHeight:440px;dialogwidth:890px;scroll:yes;status:no;help:no');
}
