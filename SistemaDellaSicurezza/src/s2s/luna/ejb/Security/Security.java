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

package s2s.luna.ejb.Security;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class Security {
//<ejb-interfaces>

public static class SecurityUserPermission implements java.io.Serializable{
      public long   lID;
      public long   lID_ASC;
      public String strName;
}

public static class SecurityUserPermissionDetails  extends SecurityUserPermission{
      public boolean 		bCanCreate=false;
      public boolean 		bCanSave=false;
      public boolean 		bCanList=false;
      public boolean 		bCanSearch=true; // depriiated
      public boolean 		bCanDelete=false;
      public boolean 		bCanEnable=false;
      public boolean 		bCanAssociateCreate=false;
      public boolean 		bCanAssociateDelete=false;
      public boolean 		bCanPrint=false;
      public boolean 		bCanPrint2=false;
      public boolean 		bCanReturn=true; // depriiated
      public boolean 		bCanDetalize=false;
      public boolean 		bCanCopyFrom=false; // Copia da

      public void allow(){
                       bCanCreate=true;
                       bCanSave=true;
                       bCanList=true;
                       bCanSearch=true;
                       bCanDelete=true;
                       bCanAssociateCreate=true;
                       bCanAssociateDelete=true;
                       bCanPrint=true;
                       bCanPrint2=true;
                       bCanReturn=true;
                       bCanDetalize=true;
                       bCanCopyFrom=true; // Copia da
      }

      public String toString(){
              return "[Permission] Name:["+strName+"] \n\t"+
              "bCanCreate=["+ bCanCreate+"] \n\t"+
              "bCanSave=["+ bCanSave+"] \n\t"+
              "bCanList=["+ bCanList+"] \n\t"+
              "bCanSearch=["+ bCanSearch+"] \n\t"+
              "bCanDelete=["+ bCanDelete+"] \n\t"+
              "bCanAssociateCreate=["+ bCanAssociateCreate+"] \n\t"+
              "bCanAssociateDelete=["+ bCanAssociateDelete+"] \n\t"+
              "bCanPrint=["+ bCanPrint+"] \n\t"+
              "bCanPrint2=["+ bCanPrint2+"] \n\t"+
              "bCanReturn=["+ bCanReturn+"] \n\t"+
              "bCanDetalize=["+ bCanDetalize+"] \n\t"+
              "bCanCopyFrom=["+ bCanCopyFrom+"] \n\t";
      }
}

public static class  SecurityModule  implements java.io.Serializable{
      public long			lID;
      public String		strName;
      public long			lType;
      public String 		strPermission;
      public long 		lID_Permission;
      public boolean 		bRequireCreate;
      public boolean 		bRequireSave;
      public boolean 		bRequireList;
      public boolean 		bRequireSearch;
      public boolean 		bRequireDelete;

      public boolean 		bRequireAssociateCreate;
      public boolean 		bRequireAssociateDelete;
      public boolean 		bRequirePrint;
      public boolean 		bRequirePrint2;
      public boolean 		bRequireReturn;
      public boolean 		bRequireDetalize;

      public String 		strRequest="";

      public String toString(){
              return "[Module] Name:["+strName+"]"+" Type:["+lType+"] \n\tPermission["+ strPermission+"] \n\t"+
              "bRequireCreate=["+ bRequireCreate+"] \n\t"+
              "bRequireSave=["+ bRequireSave+"] \n\t"+
              "bRequireList=["+ bRequireList+"] \n\t"+
              "bRequireSearch=["+ bRequireSearch+"] \n\t"+
              "bRequireDelete=["+ bRequireDelete+"] \n\t"+
              "bRequireAssociateCreate=["+ bRequireAssociateCreate+"] \n\t"+
              "bRequireAssociateDelete=["+ bRequireAssociateDelete+"] \n\t"+
              "bRequirePrint=["+ bRequirePrint+"] \n\t"+
              "bRequirePrint2=["+ bRequirePrint2+"] \n\t"+
              "bRequireReturn=["+ bRequireReturn+"] \n\t"+
              "bRequireDetalize=["+ bRequireDetalize+"] \n\t"+
              "strRequest=["+ strRequest+"] \n\t"
              ;
      }
}

}
