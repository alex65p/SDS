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

/*
<file>
  <versions>	
    <version number="1.0" date="24/02/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="24/02/2004" author="Kushkarov Yura">
				   <description>Script for GEST_MAN</description>
				 </comment>
				 <comment date="25/02/2004" author="Pogrebnoy Yura">
				   <description>Script for GEST_MAN</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/

/*function setChecked(val,mode,id)
{
var id_before="";
if(mode=="add")
{
  if (val!="0")
	{
		if (document.all['IDS'].value.indexOf(","+val+",",0)>=0)
	  {
	  pos1=document.all['IDS'].value.indexOf(","+val+",",0);
		pos2=document.all['IDS'].value.indexOf(",",pos1+1);
		document.all['IDS'].value=document.all['IDS'].value.substring(0,pos1)+document.all['IDS'].value.substring(pos2,document.all['IDS'].value.length);
	  }
	  else
	  {
	  document.all['IDS'].value=document.all['IDS'].value+val+",";
	  }
	}
}
else
{
id_before=document.all['id_bef'].value;
if (document.all['IDS'].value.length>1)
	{
	  if (id!=id_before){
	  if (confirm(arraylng["MSG_0035"]));
		  {
		   if(val!="0")
			 {
			   document.all['IDS'].value=","+val+",";
			   document.all[id_before].checked=false;
		   }
		  }
		}
		else
		{
			document.all['IDS'].value=",";
			document.all[id_before].checked=false;
		}
	}
else
  {
	document.all['IDS'].value=document.all['IDS'].value+val+",";
  }
id_before=id;
document.all['id_bef'].value=id_before;

}
}*/

//=================================================================
function setCheckedATT(val,id)
{
 var id_before="";
  if (val!="0")
	{
	if (document.all['IDSATT'].value.indexOf(","+val+",",0)>=0)
	{
	pos1=document.all['IDSATT'].value.indexOf(","+val+",",0);
	pos2=document.all['IDSATT'].value.indexOf(",",pos1+1);
	document.all['IDSATT'].value=document.all['IDSATT'].value.substring(0,pos1)+document.all['IDSATT'].value.substring(pos2,document.all['IDSATT'].value.length);
	}else{
	document.all['IDSATT'].value=document.all['IDSATT'].value+val+",";
	}
  }
}
//=================================================================
function setCheckedLUO(val,id)
{
 var id_before="";
  if (val!="0")
	{
	if (document.all['IDSLUO'].value.indexOf(","+val+",",0)>=0)
	{
	  pos1=document.all['IDSLUO'].value.indexOf(","+val+",",0);
		pos2=document.all['IDSLUO'].value.indexOf(",",pos1+1);
		document.all['IDSLUO'].value=document.all['IDSLUO'].value.substring(0,pos1)+document.all['IDSLUO'].value.substring(pos2,document.all['IDSLUO'].value.length);
	}else{
	  document.all['IDSLUO'].value=document.all['IDSLUO'].value+val+",";
	}
  }
}
//Pogrebnoy Yura functions
//=================================================================
function selectATT(){
  if (document.all["checkATT"].checked==true){
	  document.all["IDSATT"].value=",";
	  for(i=1;i<=checksum;i++){
	  		//if (document.all["checkATT"+i].current) continue;
		    document.all["checkATT"+i].checked=true;
			setCheckedATT(document.all["checkATT"+i].value,"checkATT"+i);
		}
  }else{
	  for(i=1;i<=checksum;i++){
	  	//if (document.all["checkATT"+i].disabled) continue;
		document.all["checkATT"+i].checked=false;
	  }
		document.all["IDSATT"].value=",";
	}
}
//=================================================================
function changeATT(i){
  if (document.all["checkATT"+i].disabled) return;	
  if(document.all["checkATT"+i].checked==true){
	   document.all["checkATT"+i].checked=false;
	}else{
     document.all["checkATT"+i].checked=true;
	}
	setCheckedATT(document.all["checkATT"+i].value,"checkATT"+i);
}
//=================================================================
function selectLUO(){
  if (document.all["checkLUO"].checked==true){
	  document.all["IDSLUO"].value=",";
	  for(i=1;i<=checksumluo;i++){
		  // if (document.all["checkLUO"+i].current) continue;
		  document.all["checkLUO"+i].checked=true;
		  setCheckedLUO(document.all["checkLUO"+i].value,"checkLUO"+i);
		}
  }else{
	  for(i=1;i<=checksumluo;i++){
	  	//if (document.all["checkLUO"+i].disabled) continue;
		document.all["checkLUO"+i].checked=false;
	  }
		document.all["IDSLUO"].value=",";
	}
}
//=================================================================
function changeLUO(i){
  if (document.all["checkLUO"+i].disabled) return;
  if(document.all["checkLUO"+i].checked==true){
	   document.all["checkLUO"+i].checked=false;
	}else{
     document.all["checkLUO"+i].checked=true;
	}
	setCheckedLUO(document.all["checkLUO"+i].value,"checkLUO"+i);
}
//=================================================================

