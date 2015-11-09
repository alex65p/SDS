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

< %
/*
<file>
  <versions>	
    <version number="1.0" date="27/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="27/01/2004" author="Artur Denysenko">
				   Interfaces dlia objecta AnagCorso
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

  public interface IAnagCorso extends EJBObject
  {
  	public long getCOD_COR();

	public long getDUR_COR_GOR();
	public void setDUR_COR_GOR(long lDUR_COR_GOR);

	public String getNOM_COR();
	public void setNOM_COR(String strNOM_COR);

	public String getDES_COR();
	public void setDES_COR(String strDES_COR);

	public String getUSO_ATE_FRE_COR();
	public void setUSO_ATE_FRE_COR(String strUSO_ATE_FRE_COR);

	public String getUSO_PTG_COR();
	public void setUSO_PTG_COR(String strUSO_PTG_COR);

	public long getCOD_TPL_COR();
	public void setCOD_TPL_COR(long lCOD_TPL_COR);


  }

  public interface IAnagCorsoHome extends EJBHome
  {
     public IAnagCorso create(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) throws CreateException;
     public IAnagCorso findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
  }
  
	
//<ejb-interfaces>
%>

