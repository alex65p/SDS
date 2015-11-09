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
    <version number="1.0" date="06/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="06/02/2004" author="Artur Denysenko">
				   Interfaces dlia objecta DestinatarioDocumento
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="java.util.*"%>

<%!
//<ejb-interfaces description="EJB Interfaces">

  public interface  IDestinatarioDocumento extends EJBObject
  {
  	public long getCOD_LST_DSI_DOC();

	public String getNOM_DSI_ESR();
	public void setNOM_DSI_ESR(String strNOM_DSI_ESR);

	public String getDES_DSI_ESR();
	public void setDES_DSI_ESR(String strDES_DSI_ESR);

	public String getIDZ_PSA_ELT_DSI_ESR();
	public void setIDZ_PSA_ELT_DSI_ESR(String strIDZ_PSA_ELT_DSI_ESR);

	public java.sql.Date getDAT_CSG_DOC_DSI();
	public void setDAT_CSG_DOC_DSI(java.sql.Date dtDAT_CSG_DOC_DSI);

	public long getCOD_DOC();
	public void setCOD_DOC(long lCOD_DOC);

	public long getCOD_DTE();
	public void setCOD_DTE(long lCOD_DTE);

	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);

	public long getCOD_UNI_ORG();
	public void setCOD_UNI_ORG(long lCOD_UNI_ORG);
	
	//public void setCOD_DPD__DPD_AZL(long lCOD_AZL, long lCOD_DPD);


  }

  public interface IDestinatarioDocumentoHome extends EJBHome
  {
     public IDestinatarioDocumento create(long lCOD_DOC, long lCOD_AZL) throws CreateException;
     public IDestinatarioDocumento findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
  }
  
//<ejb-interfaces>
%>
