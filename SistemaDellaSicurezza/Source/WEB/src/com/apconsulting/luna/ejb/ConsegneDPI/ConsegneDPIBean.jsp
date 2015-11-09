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

<%
/*
<file>
  <versions>	
    <version number="1.0" date="22/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="22/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class ConsegneDPIBean extends BMPEntityBean implements IConsegneDPI, IConsegneDPIHome
//class ConsegneDPIBean extends IConsegneDPIHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long   COD_CSG_DPI;                //1
	COD_DPD
	DAT_CSG_DPI
	
	String NOM_TIT_STU_SPC;            //2
	String DES_TIT_STU_SPC;            //3
	String TLP_TIT_STU_SPC;            //4
  long   COD_DPD;            				 //5
  long   COD_AZL;            				 //6
  //----------------------------

  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private ConsegneDPIBean()
  {
	//System.err.println("ConsegneDPIBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IConsegneDPI create(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL) throws CreateException
  {
 	 ConsegneDPIBean bean =  new  ConsegneDPIBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_TIT_STU_SPC, strDES_TIT_STU_SPC, strTLP_TIT_STU_SPC, lCOD_DPD, lCOD_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_TIT_STU_SPC, strDES_TIT_STU_SPC, strTLP_TIT_STU_SPC, lCOD_DPD, lCOD_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	ConsegneDPIBean iConsegneDPIBean=new  ConsegneDPIBean();
    try
	{
    	Object obj=iConsegneDPIBean.ejbFindByPrimaryKey((Long)primaryKey);
        iConsegneDPIBean.setEntityContext(new EntityContextWrapper(obj));
        iConsegneDPIBean.ejbActivate();
        iConsegneDPIBean.ejbLoad();
        iConsegneDPIBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex); 
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IConsegneDPI findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	ConsegneDPIBean bean =  new  ConsegneDPIBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IConsegneDPIHome-implementation>
  public Long ejbCreate(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL)
  {
    this.COD_TIT_STU_SPC=NEW_ID(); // unic ID
		this.NOM_TIT_STU_SPC=strNOM_TIT_STU_SPC;
		this.DES_TIT_STU_SPC=strDES_TIT_STU_SPC;
		this.TLP_TIT_STU_SPC=strTLP_TIT_STU_SPC;
		this.COD_DPD=lCOD_DPD;
		this.COD_AZL=lCOD_AZL;
		
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO tit_stu_spc_tab (cod_tit_stu_spc,nom_tit_stu_spc,des_tit_stu_spc,tlp_tit_stu_spc,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?)");
         ps.setLong   (1, COD_TIT_STU_SPC);
         ps.setString (2, NOM_TIT_STU_SPC);
				 ps.setString (3, DES_TIT_STU_SPC);
				 ps.setString (4, TLP_TIT_STU_SPC);
				 ps.setLong   (5, COD_DPD);
				 ps.setLong   (6, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_TIT_STU_SPC);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tit_stu_spc FROM tit_stu_spc_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

//-----------------------------------------------------------
  	
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_TIT_STU_SPC=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_TIT_STU_SPC=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tit_stu_spc_tab  WHERE cod_tit_stu_spc=?");
           ps.setLong (1, COD_TIT_STU_SPC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NOM_TIT_STU_SPC=rs.getString("NOM_TIT_STU_SPC");
  			   this.DES_TIT_STU_SPC=rs.getString("DES_TIT_STU_SPC");
					 this.TLP_TIT_STU_SPC=rs.getString("TLP_TIT_STU_SPC");
					 this.COD_DPD=rs.getLong("COD_DPD");
					 this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("ConsegneDPI con ID="+COD_TIT_STU_SPC+" non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tit_stu_spc_tab  WHERE cod_tit_stu_spc=?");
          ps.setLong (1, COD_TIT_STU_SPC);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("ConsegneDPI con ID="+COD_TIT_STU_SPC+" non è trovata");
      }
      catch(Exception ex)
	  {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }  
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE tit_stu_spc_tab  SET nom_tit_stu_spc=?, des_tit_stu_spc=?, tlp_tit_stu_spc=?, cod_dpd=?, cod_azl=? WHERE cod_tit_stu_spc=?");
          ps.setString(1, NOM_TIT_STU_SPC);
          ps.setString(2, DES_TIT_STU_SPC);
					ps.setString(3, TLP_TIT_STU_SPC);
		      ps.setLong  (4, COD_DPD);
		      ps.setLong  (5, COD_AZL);
					ps.setLong  (6, COD_TIT_STU_SPC);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("ConsegneDPI con ID="+COD_TIT_STU_SPC+" non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">  
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">  
	//1
  	 public void setNOM_TIT_STU_SPC(String newNOM_TIT_STU_SPC){
      if( NOM_TIT_STU_SPC.equals(newNOM_TIT_STU_SPC) ) return;
      NOM_TIT_STU_SPC = newNOM_TIT_STU_SPC;
      setModified();
    }
    public String getNOM_TIT_STU_SPC(){
      return NOM_TIT_STU_SPC;
    }
	//2
  	 public void setDES_TIT_STU_SPC(String newDES_TIT_STU_SPC){
      if( DES_TIT_STU_SPC.equals(newDES_TIT_STU_SPC) ) return;
      DES_TIT_STU_SPC = newDES_TIT_STU_SPC;
      setModified();
    }
    public String getDES_TIT_STU_SPC(){
      return DES_TIT_STU_SPC;
    }
	//3
  	 public void setTLP_TIT_STU_SPC(String newTLP_TIT_STU_SPC){
      if( TLP_TIT_STU_SPC.equals(newTLP_TIT_STU_SPC) ) return;
      TLP_TIT_STU_SPC = newTLP_TIT_STU_SPC;
      setModified();
    }
    public String getTLP_TIT_STU_SPC(){
      return TLP_TIT_STU_SPC;
    }
	//4
    public long getCOD_DPD(){
      return COD_DPD;
    }
	//5
    public long getCOD_AZL(){
      return COD_AZL;
    }
		
	//6
    public long getCOD_TIT_STU_SPC(){
      return COD_TIT_STU_SPC;
    }
	//============================================
	// not required field
	//3
//  	public void setDES_TIT_STU_SPC(String newDES_TIT_STU_SPC){
//    if(DES_TIT_STU_SPC!=null){
//  	if( DES_TIT_STU_SPC.equals(newDES_TIT_STU_SPC) ) return;
//	  }
//	  DES_TIT_STU_SPC = newDES_TIT_STU_SPC;
//	  setModified();
//    }
//    public String getDES_TIT_STU_SPC(){
//      if(DES_TIT_STU_SPC==null){return "";}
//			return DES_TIT_STU_SPC;
//    }
	
   //</comment>
  
  //-------------------
  //</comment>         

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  ConsegneDPIBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("ConsegneDPIBean", new ConsegneDPIBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
