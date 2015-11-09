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

/*
 * ContainerSQLFactory.java
 *
 * Created on 22 marzo 2007, 10.09
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.SQLConfigurator.sqlContainer;

import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPConnection.ConnectionType;

/**
 *
 * @author dario.massaroni
 */
public class ContainerSQLFactory {
    
    private static ContainerSQL SQL;

    public static ContainerSQL getContainerSQLInstance(){
        ConnectionType DataBaseConnectionType = BMPConnection.getConnectionType();
        if (    SQL == null ||
                !((DataBaseConnectionType == ConnectionType.POSTGRE && SQL instanceof ContainerSQL_PostGre) ||
                (DataBaseConnectionType == ConnectionType.ORACLE && SQL instanceof ContainerSQL_Oracle) ||
                (DataBaseConnectionType == ConnectionType.MYSQL && SQL instanceof ContainerSQL_MySql) ||
                (DataBaseConnectionType == ConnectionType.DB2 && SQL instanceof ContainerSQL_DB2))
            ){
            if (DataBaseConnectionType == ConnectionType.POSTGRE){
                SQL = new ContainerSQL_PostGre();
            } else
            if (DataBaseConnectionType == ConnectionType.ORACLE){
                SQL = new ContainerSQL_Oracle();
            } else
            if (DataBaseConnectionType == ConnectionType.MYSQL){
                SQL = new ContainerSQL_MySql();
            } else
            if (DataBaseConnectionType == ConnectionType.DB2){
                SQL = new ContainerSQL_DB2();
            }
        }
           return SQL;
    }
    
    /** Creates a new instance of ContainerSQLFactory */
    private ContainerSQLFactory() {
    }
    
}
