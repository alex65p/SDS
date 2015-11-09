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
    <version number="1.0" date="07/12/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="07/12/2004" author="Artur Denysenko">
				   <description>Interfaces dlia objecta Firma</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%
//<ejb-interfaces description="EJB Interfaces">
    //public interface  IFirm extends EJBObject
    abstract class IFirm extends BMPEntityBean
    {
      public abstract 	String getName() ;
      public abstract 	void setName(String newName);
      public abstract 	String getDescription();
      public abstract 	void setDescription(String newDescription);
      public abstract 	long getID();

      public  abstract	Collection getEmployees();
      public  abstract 	void addEmployee(EnterpriseBean employee);
      public  abstract 	void removeEmployee(EnterpriseBean employee);

      public  abstract 	EnterpriseBean createEmployee(String strName, String strSurname);
    }

    //public interface IFirmHome extends EJBHome
    abstract class IFirmHome extends  IFirm
    {
       public abstract IFirm create(String strName, String strDescription) throws CreateException;
       public abstract IFirm findByPrimaryKey(Long primaryKey) throws FinderException;
       public abstract Collection findAll() throws FinderException;
       public abstract Collection getView();
    }
//<ejb-interfaces>

//<viwes">
  /*public*/ class FirmView implements java.io.Serializable{
    public long ID;
    public String Name, Description;

  }
//</viwes>

%>
