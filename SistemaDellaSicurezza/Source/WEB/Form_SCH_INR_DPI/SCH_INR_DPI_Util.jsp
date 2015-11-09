<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%!
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="25/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi NAT_LES_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
String BuildIdentLotComboBox(ILottiDPIHome home, long SELECTED_ID, long AZL_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getLottiDPI_IDE_DATA_View(AZL_ID);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
	  LottiDPI_IDE_DATA_View  dt = (LottiDPI_IDE_DATA_View)it.next();
	  long var1=dt.COD_LOT_DPI;
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==var1){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+var1+"\">"+dt.IDE_LOT_DPI+"</option>";
  	}
	return str;
}
%>
