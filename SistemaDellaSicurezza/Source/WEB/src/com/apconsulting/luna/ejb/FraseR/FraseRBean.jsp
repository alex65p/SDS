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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="24/01/2004" author="Khomenko Juliya">
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

public class FraseRBean extends BMPEntityBean implements IFraseR, IFraseRHome
//class FraseRBean extends IFraseRHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long   COD_FRS_R;            //1
	String NUM_FRS_R;            //2
  String DES_FRS_R;            //3
  //----------------------------
	double	 VAL_INA;							 //4
	double   VAL_CCP;							 //5
	double   VAL_ING;							 //6
	double   VAL_IRR;							 //7
	double   VAL_ESP;							 //8
	double   VAL_UNI;							 //9
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
 private FraseRBean()
  {
	//System.err.println("FraseRBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IFraseR create(String strNUM_FRS_R, String strDES_FRS_R) throws CreateException
  {
 	 FraseRBean bean =  new  FraseRBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNUM_FRS_R, strDES_FRS_R);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNUM_FRS_R, strDES_FRS_R);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	FraseRBean iFraseRBean=new  FraseRBean();
    try
	{
    	Object obj=iFraseRBean.ejbFindByPrimaryKey((Long)primaryKey);
        iFraseRBean.setEntityContext(new EntityContextWrapper(obj));
        iFraseRBean.ejbActivate();
        iFraseRBean.ejbLoad();
        iFraseRBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IFraseR findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	FraseRBean bean =  new  FraseRBean();
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

  //</IFraseRHome-implementation>
  public Long ejbCreate(String strNUM_FRS_R, String strDES_FRS_R)
  {
    this.NUM_FRS_R=strNUM_FRS_R;
    this.DES_FRS_R=strDES_FRS_R;
		this.COD_FRS_R=NEW_ID(); // unic ID
		//this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_frs_r_tab (cod_frs_r,num_frs_r,des_frs_r) VALUES(?,?,?)");
         ps.setLong   (1, COD_FRS_R);
         ps.setString (2, NUM_FRS_R);
         ps.setString (3, DES_FRS_R);
         ps.executeUpdate();
         return new Long(COD_FRS_R);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNUM_FRS_R, String strDES_FRS_R) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_frs_r FROM ana_frs_r_tab ");
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
    this.COD_FRS_R=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_FRS_R=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_frs_r_tab  WHERE cod_frs_r=?");
           ps.setLong (1, COD_FRS_R);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NUM_FRS_R=rs.getString("NUM_FRS_R");
  			   this.DES_FRS_R=rs.getString("DES_FRS_R");
					 this.VAL_INA=rs.getDouble("VAL_INA");
					 this.VAL_CCP=rs.getDouble("VAL_CCP");
					 this.VAL_ING=rs.getDouble("VAL_ING");
					 this.VAL_IRR=rs.getDouble("VAL_IRR");
		       this.VAL_ESP=rs.getDouble("VAL_ESP");
		       this.VAL_UNI=rs.getDouble("VAL_UNI");
           }
           else{
              throw new NoSuchEntityException("FraseR con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_frs_r_tab  WHERE cod_frs_r=?");
          ps.setLong (1, COD_FRS_R);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("FraseR con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_frs_r_tab  SET num_frs_r=?, des_frs_r=?, val_ina=?, val_ccp=?, val_ing=?, val_irr=?, val_esp=?, val_uni=?  WHERE cod_frs_r=?");
          ps.setString(1, NUM_FRS_R);
          ps.setString(2, DES_FRS_R);
					ps.setDouble  (3, VAL_INA);
					ps.setDouble  (4, VAL_CCP);
					ps.setDouble  (5, VAL_ING);
					ps.setDouble  (6, VAL_IRR);
		      ps.setDouble  (7, VAL_ESP);
		      ps.setDouble  (8, VAL_UNI);
					ps.setDouble  (9, COD_FRS_R);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("FraseR con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------
   //<report>
  	 public Collection getFraseR_View(){
	 	return this.ejbGetFraseR_View();
	 }

	 public Collection ejbGetFraseR_View(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT s.cod_frs_r, s.num_frs_r, s.des_frs_r, "+
         	"s.val_ina, s.val_ccp, s.val_ing, s.val_irr, s.val_esp, s.val_uni "+
         	"FROM ana_frs_r_tab s ORDER BY s.num_frs_r");
           ResultSet rs=ps.executeQuery();
		   ArrayList al= new ArrayList();
           while(rs.next()){
           		FraseR_View w= new FraseR_View();
				w.lCOD_FRS_R=rs.getLong(1);
				w.strNUM_FRS_R=rs.getString(2);
				w.strDES_FRS_R=rs.getString(3);
				w.strVAL_INA=rs.getString(4);
				w.strVAL_CCP=rs.getString(5);
				w.strVAL_ING=rs.getString(6);
				w.strVAL_IRR=rs.getString(7);
				w.strVAL_ESP=rs.getString(8);
				w.strVAL_UNI=rs.getString(9);
				al.add(w);
           }
			return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	 }
   //</report>

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">
	//1
  	 public void setNUM_FRS_R(String newNUM_FRS_R){
      if( NUM_FRS_R.equals(newNUM_FRS_R) ) return;
      NUM_FRS_R = newNUM_FRS_R;
      setModified();
    }
    public String getNUM_FRS_R(){
      return NUM_FRS_R;
    }
	//2
  	 public void setDES_FRS_R(String newDES_FRS_R){
      if( DES_FRS_R.equals(newDES_FRS_R) ) return;
      DES_FRS_R = newDES_FRS_R;
      setModified();
    }
    public String getDES_FRS_R(){
      return DES_FRS_R;
    }
	//3
    public long getCOD_FRS_R(){
      return COD_FRS_R;
    }
	//============================================
	// not required field
	//4
    public void setVAL_INA(double newVAL_INA){
      if( VAL_INA == newVAL_INA ) return;
      VAL_INA = newVAL_INA;
	  setModified();
    }
    public double getVAL_INA(){
      return VAL_INA;
    }
	//5
    public void setVAL_CCP(double newVAL_CCP){
      if( VAL_CCP == newVAL_CCP ) return;
      VAL_CCP = newVAL_CCP;
	  setModified();
    }
    public double getVAL_CCP(){
      return VAL_CCP;
    }
	//6
    public void setVAL_ING(double newVAL_ING){
      if( VAL_ING == newVAL_ING ) return;
      VAL_ING = newVAL_ING;
	  setModified();
    }
    public double getVAL_ING(){
      return VAL_ING;
    }
	//7
    public void setVAL_IRR(double newVAL_IRR){
      if( VAL_IRR == newVAL_IRR ) return;
      VAL_IRR = newVAL_IRR;
	  setModified();
    }
    public double getVAL_IRR(){
      return VAL_IRR;
    }
	//8
    public void setVAL_ESP(double newVAL_ESP){
      if( VAL_ESP == newVAL_ESP ) return;
      VAL_ESP = newVAL_ESP;
	  setModified();
    }
    public double getVAL_ESP(){
      return VAL_ESP;
    }
	//9
    public void setVAL_UNI(double newVAL_UNI){
      if( VAL_UNI == newVAL_UNI ) return;
      VAL_UNI = newVAL_UNI;
	  setModified();
    }
    public double getVAL_UNI(){
      return VAL_UNI;
    }

   //</comment>

  //-------------------
  //</comment>

//====by Juli==========
   public Collection findEx(  
											  String strNUM_FRS_R,
										    String strDES_FRS_R,
										    double lVAL_INA,
										    double lVAL_CCP,
										    double lVAL_ING,
										    double lVAL_IRR,
										    double lVAL_ESP,
										    double lVAL_UNI,
											  int iOrderBy /*not used for now*/
									)
	{
		return ejbFindEx( 
											  strNUM_FRS_R,
										    strDES_FRS_R,
										    lVAL_INA,
										    lVAL_CCP,
										    lVAL_ING,
										    lVAL_IRR,
										    lVAL_ESP,
										    lVAL_UNI,
												iOrderBy);
	}

 	public Collection ejbFindEx(  
											  String strNUM_FRS_R,
										    String strDES_FRS_R,
										    double lVAL_INA,
										    double lVAL_CCP,
										    double lVAL_ING,
										    double lVAL_IRR,
										    double lVAL_ESP,
										    double lVAL_UNI,
											int iOrderBy 
									){
									
			//
			String lVAL_INA_STR = (new Double(lVAL_INA)).toString();
			String lVAL_CCP_STR = (new Double(lVAL_CCP)).toString();
			String lVAL_ING_STR = (new Double(lVAL_ING)).toString();
			String lVAL_IRR_STR = (new Double(lVAL_IRR)).toString();
			String lVAL_ESP_STR = (new Double(lVAL_ESP)).toString();
			String lVAL_UNI_STR = (new Double(lVAL_UNI)).toString();
			//
			String strSql=" SELECT cod_frs_r,num_frs_r,des_frs_r,val_ina,val_ccp, "+
			              " val_ing,val_irr,val_esp,val_uni FROM ana_frs_r_tab WHERE cod_frs_r<>0 ";
			
			if(strNUM_FRS_R!=null){
				strSql+="AND UPPER(num_frs_r) LIKE ? ";
			}
			if(strDES_FRS_R!=null){
				strSql+="AND UPPER(des_frs_r) LIKE ? ";
			}
			if(lVAL_INA!=0){
				strSql+="AND VAL_INA=? ";
			}
			if(lVAL_CCP!=0){
				strSql+="AND VAL_CCP=? ";
			}
			if(lVAL_ING!=0){
				strSql+="AND VAL_ING=? ";
			}
			if(lVAL_IRR!=0){
				strSql+="AND VAL_IRR=? ";
			}
			if(lVAL_ESP!=0){
				strSql+="AND VAL_ESP = ? ";
			}
			if(lVAL_UNI!=0){
				strSql+="AND VAL_UNI = ? ";
			}
			strSql+=" ORDER BY num_frs_r "+ (iOrderBy>0?" ASC": "DESC");
			int i=1;
			BMPConnection bmp=getConnection();
		     try{
					PreparedStatement ps=bmp.prepareStatement(strSql);
					if(strNUM_FRS_R!=null){
						ps.setString(i++, strNUM_FRS_R.toUpperCase());
					}
					if(strDES_FRS_R!=null){
						ps.setString(i++, strDES_FRS_R.toUpperCase());
					}
					if(lVAL_INA!=0){
						ps.setString(i++, lVAL_INA_STR);
					}
					if(lVAL_CCP!=0){
						ps.setString(i++, lVAL_CCP_STR);
					}
					if(lVAL_ING!=0){
						ps.setString(i++, lVAL_ING_STR);
					}
					if(lVAL_IRR!=0){
						ps.setString(i++, lVAL_IRR_STR);
					}
					if(lVAL_ESP!=0){
						ps.setString(i++, lVAL_ESP_STR);
					}
					if(lVAL_UNI!=0){
						ps.setString(i++, lVAL_UNI_STR);
					}
				   //----------------------------------------------------------------------
				   ResultSet rs=ps.executeQuery();
	               java.util.ArrayList ar= new java.util.ArrayList();
	               while(rs.next()){
	                    FraseR_View v=new FraseR_View();
	                    v.lCOD_FRS_R=rs.getLong(1);
						v.strNUM_FRS_R=rs.getString(2);
						v.strDES_FRS_R=rs.getString(3);
						v.strVAL_INA=rs.getString(4);
						v.strVAL_CCP=rs.getString(5);
						v.strVAL_ING=rs.getString(6);
						v.strVAL_IRR=rs.getString(7);
						v.strVAL_ESP=rs.getString(8);
						v.strVAL_UNI=rs.getString(9);
	                    ar.add(v);
	               }
				    return ar;
				   //----------------------------------------------------------------------
		  }
          catch(Exception ex){
              throw new EJBException(ex);
          }
		  finally{bmp.close();}
	}

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  FraseRBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("FraseRBean", new FraseRBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
