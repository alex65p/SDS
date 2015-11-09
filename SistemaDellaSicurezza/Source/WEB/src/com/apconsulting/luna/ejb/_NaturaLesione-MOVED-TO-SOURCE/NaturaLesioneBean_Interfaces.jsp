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

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%!
// BASE TABLE: NAT_LES_TAB
//     Remote Intrface EJB obiekta 
public interface INaturaLesione extends EJBObject{
  //   *Require Fields*
  public long getCOD_NAT_LES();
  public String getNOM_NAT_LES();
  public void setNOM_NAT_LES (String newNOM_NAT_LES);
}

//     Home Intrface EJB obiekta 
public interface INaturaLesioneHome extends EJBHome
{
   public INaturaLesione create(String strNOM_NAT_LES) throws CreateException;
   public void remove(Object primaryKey);
   public INaturaLesione findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
	 
	//View by Pogrebnoy Yura for ANA_INO_Combobox
	public	Collection getANA_NAT_LES_TAB_ByNOM_View();
	public	Collection findEx(String NOM, long iOrderBy);
}
class ANA_NAT_LES_TAB_ByNOM_View implements java.io.Serializable{
	long	COD_NAT_LES;
	String	NOM_NAT_LES;
}
%>
