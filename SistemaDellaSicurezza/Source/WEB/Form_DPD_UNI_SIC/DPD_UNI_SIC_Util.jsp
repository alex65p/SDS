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

<%
/*
<file>
  <versions>	
    <version number="1.0" date="24/02/2004" author="Alexey Kolesnik">
              <comments>
                                  <comment date="24/02/2004" author="Alexey Kolesnik">
                                           <description>DPD_UNI_SIC_Util.jsp-functions for DPD_UNI_SIC_From</description>
                                           <description>Functions for comboboxes </description>
                                 </comment>
                                  <comment date="26/02/2004" author="Alex Kyba">
                                           <description>
                                                        dobavlena function dlia postroeniya dereva unita organizzativa
                                                </description>
                                 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>


<%!
boolean isError=false;
String strError = "";

String BuildRuoliSicurezzaComboBox (IRuoliSicurezzaHome home, long SELECTED_ID){
        StringBuilder str = new StringBuilder();
        String strSEL="";
        java.util.Collection col = home.getRuoliSicurezza_View();
        java.util.Iterator it = col.iterator();
        while(it.hasNext()){
                RuoliSicurezza_View  dt = (RuoliSicurezza_View)it.next();
                strSEL="";
                if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_RUO_SIC){strSEL="selected";} }
                str .append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(Formatter.format(dt.COD_RUO_SIC))
                    .append("\">")
                    .append(Formatter.format(dt.NOM_RUO_SIC))
                    .append("</option>");
        }
        return str.toString();
}

//---------------------------<ALEX> ----------------------------
String buildTreeNodes(IUnitaOrganizzativa bean, IUnitaOrganizzativaHome home, long n, long COD_UNI_ORG){
        Collection c;
        Iterator i;
        String selected;
        long azienda = Security.getAzienda();
        StringBuilder strNodes = new StringBuilder();
        try{
                if (n==0){
                        c=home.getTopOfTree(azienda);
                        i=c.iterator();
                        n++;
                        if (i!=null){
                                while (i.hasNext()){
					
                                        UnitaOrganizzativaView view = (UnitaOrganizzativaView)i.next();
					
                                        String strNOM_UNI_ORG= view.strNOM_UNI_ORG;
                                        long lCOD_UNI_ORG= view.lCOD_UNI_ORG;
                                        if (COD_UNI_ORG==lCOD_UNI_ORG) selected="selected"; else selected="";
                                        strNodes.append("<option value=\"")
                                                .append(lCOD_UNI_ORG)
                                                .append("\" ")
                                                .append(selected)
                                                .append(">")
                                                .append(strNOM_UNI_ORG)
                                                .append("</option>");
                                        bean = home.findByPrimaryKey(new Long(lCOD_UNI_ORG));
                                        strNodes.append(buildTreeNodes(bean, home, n, COD_UNI_ORG));
                                        if (isError) return "";
                                }
                        }
                }
                else{
                        c=bean.getChildren(azienda);
                        i=c.iterator();
                        n++;
                        if (i!=null){
                                while (i.hasNext()){
                                        UnitaOrganizzativaView view = (UnitaOrganizzativaView)i.next();
                                        String strNOM_UNI_ORG= view.strNOM_UNI_ORG;
                                        long lCOD_UNI_ORG= view.lCOD_UNI_ORG;
                                        if (COD_UNI_ORG==lCOD_UNI_ORG) selected="selected"; else selected="";
                                        strNodes.append("<option value=\"")
                                                .append(lCOD_UNI_ORG)
                                                .append("\" ")
                                                .append(selected)
                                                .append(">");
                                        for (long y=0; y<n; y++) strNodes.append("&nbsp;&nbsp;&nbsp;");
                                        strNodes.append(strNOM_UNI_ORG)
                                                .append("</option>");
                                        bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_ORG));
                                        strNodes.append(buildTreeNodes(bean, home,n , COD_UNI_ORG));
                                        if (isError) return "";
                                }
                        }
                }
        }
        catch(Exception ex){
                strError+=ex.getMessage();
                return "";
        }
        return strNodes.toString();
}
//--------------------------</ALEX> ----------------------------
%>
