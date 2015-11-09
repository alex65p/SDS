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
				   <description>Realizazija EJB dlia objecta Firma</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>

<%
//public class FirmBean extends BMPEntityBean implements IFirm
class FirmBean extends IFirmHome
{
  //<comment description="Member Variables">
    String Name;
    String Description;
    long ID;
  //</comment>

  public FirmBean(){}

 //<IUserHome-implementation>
    public IFirm create(String strName, String strDescription){
        FirmBean bean =  new  FirmBean();
        Object primaryKey=bean.ejbCreate(strName, strDescription);
        bean.setEntityContext(new EntityContextWrapper(primaryKey));
        bean.ejbPostCreate(strName, strDescription);
        return bean;
    }
    public IFirm findByPrimaryKey(Long primaryKey){
         FirmBean bean =  new  FirmBean();
           bean.setEntityContext(new EntityContextWrapper(primaryKey));
           bean.ejbActivate();
           bean.ejbLoad();
           return bean;
    }
    public Collection findAll(){
      return this.ejbFindAll();
    }
    public Collection getView(){
      return (new  FirmBean()).ejbGetView();
   }

 //</IUserHome-implementation>

  public Long ejbCreate(String strName, String strDescription)
  {
    this.Name=strName;
    this.Description=strDescription;
    this.ID=NEW_ID(); // only example case, generaly must be taken from DB after INSERT
    this.unsetModified();

    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO FIRMS (ID_FIRM, NAME, DESCRIPTION) VALUES(?, ?, ?)");
         ps.setLong(1, ID);
         ps.setString(2, Name);
         ps.setString(3, Description);
         ps.executeUpdate();
       return new Long(ID);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

  public void ejbPostCreate(String strName, String strDescription) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ID_FIRM FROM FIRMS ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.ID=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.ID=Long.MAX_VALUE;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT NAME, DESCRIPTION FROM FIRMS  WHERE ID_FIRM=?");
           ps.setLong(1, ID);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              this.Name=rs.getString(1);
              this.Description=rs.getString(2);
           }
           else{
              throw new NoSuchEntityException("Firm with ID="+ID+" not found");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM FIRMS  WHERE ID_FIRM=?");
          ps.setLong(1, ID);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Firm with ID="+ID+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE FIRMS  SET NAME=?, DESCRIPTION=? WHERE ID_FIRM=?");
          ps.setString(1, Name);
          ps.setString(2, Description);
          ps.setLong(3, ID);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Firm with ID="+ID+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

   //<comment description="methods">
      public  EnterpriseBean createEmployee(String strName, String strSurname){
          try{
             IUserHome home=(IUserHome)PseudoContext.lookup("UserBean");
             IUser user = home.create(strName, strSurname);
             this.addEmployee(user);
             return user;
              }
          catch(Exception ex){
            throw new EJBException(ex);
          }
      }
   //<comment>
   //<comment description="extended setters/getters">
        public Collection ejbGetView(){
             BMPConnection bmp=getConnection();
            try{
                PreparedStatement ps=bmp.prepareStatement("SELECT NAME, DESCRIPTION, ID_FIRM FROM FIRMS ");
                ResultSet rs=ps.executeQuery();
                java.util.ArrayList al=new java.util.ArrayList();
                while(rs.next()){
                  FirmView fw=new FirmView();
                  fw.Name=rs.getString(1);
                  fw.Description=rs.getString(2);
                  fw.ID=rs.getLong(3);
                  al.add(fw); // performance of the [new] operator?
                }
                return al;
            }
            catch(Exception ex){
                throw new EJBException(ex);
            }
           finally{bmp.close();}
        }


        public Collection getEmployees(){
            BMPConnection bmp=getConnection();
            try{
                PreparedStatement ps=bmp.prepareStatement("SELECT FID_USER FROM FIRM_EMPLOYEES WHERE FID_FIRM=?");
                ps.setLong(1, ID);
                ResultSet rs=ps.executeQuery();
                java.util.ArrayList al=new java.util.ArrayList();
                while(rs.next()){
                  al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
                }
                bmp.close();
                return al;
            }
            catch(Exception ex){
                throw new EJBException(ex);
            }
           finally{bmp.close();}
        }

        public void addEmployee(EnterpriseBean bean){
          IUser employee=(IUser)bean;
          BMPConnection bmp=getConnection();
          try{
        //dlia prostoti ne proveriaem na unikalnost' -- VIF
             PreparedStatement ps=bmp.prepareStatement("INSERT INTO FIRM_EMPLOYEES (FID_FIRM, FID_USER) VALUES(?, ?)");
               ps.setLong(1, ID);
               ps.setLong(2, employee.getID());
               if(ps.executeUpdate()==0) throw new NoSuchEntityException("Can't add new Employee, "+ID+" not found");
          }
          catch(Exception ex){
              throw new EJBException(ex);
          }
          finally{bmp.close();}
        }

        public  void removeEmployee(EnterpriseBean bean){
          IUser employee=(IUser)bean;
          BMPConnection bmp=getConnection();
          try{
        //dlia prostoti ne proveriaem na unikalnost' -- VIF
             PreparedStatement ps=bmp.prepareStatement("DELETE FROM FIRM_EMPLOYEES WHERE FID_FIRM=? AND FID_USER=?");
               ps.setLong(1, ID);
               ps.setLong(2, employee.getID());
               if(ps.executeUpdate()==0) throw new NoSuchEntityException("Can't delete Employee, "+ID+" not found");
          }
          catch(Exception ex){
              throw new EJBException(ex);
          }
          finally{bmp.close();}
        }
   //</comment>
  //<comment description="setter/getters">
        public String getName()
        {
          return Name;
        }

        public void setName(String newName){
          if(Name == newName) return;
          Name = newName;
          setModified();
        }

        public String getDescription(){
          return Description;
        }

        public void setDescription(String newDescription){
          if(Description == newDescription) return;
          Description = newDescription;
          setModified();
        }

        public long getID(){
          return ID;
        }
  //</comment>

}//class FirmBean

////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
PseudoContext.bind("FirmBean", new FirmBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////

%>
