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
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package s2s.luna.util;

import javax.ejb.EJBException;
import s2s.luna.conf.ApplicationConfigurator;
import java.sql.SQLException;
/**
 *
 * @author Dario
 */
public class ExceptionInfo extends Exception {
    public enum exceptionType {
        NOT_DETERMINABLE 
                (ApplicationConfigurator.LanguageManager.getString("N.A"),  // userCategory
                ApplicationConfigurator.LanguageManager.getString("N.A"),   // userMessage
                ApplicationConfigurator.LanguageManager.getString("N.A"),   // cause
                ApplicationConfigurator.LanguageManager.getString("N.A")),  // solution
        GENERIC_ERROR 
                (ApplicationConfigurator.LanguageManager.getString("N.A"),
                ApplicationConfigurator.LanguageManager.getString("N.A"),
                ApplicationConfigurator.LanguageManager.getString("N.A"),
                ApplicationConfigurator.LanguageManager.getString("N.A")), 
        GENERIC_DATABASE_ERROR 
                (ApplicationConfigurator.LanguageManager.getString("Segnalazione.del.database"),
                ApplicationConfigurator.LanguageManager.getString("Segnalazione.database.errore.generico"),
                ApplicationConfigurator.LanguageManager.getString("N.A"),
                ApplicationConfigurator.LanguageManager.getString("N.A")), 
        INTEGRITY_CONSTRAINT_VIOLATION 
                (ApplicationConfigurator.LanguageManager.getString("Segnalazione.del.database"),
                ApplicationConfigurator.LanguageManager.getString("Segnalazione.integrity.constraint.violation"),
                ApplicationConfigurator.LanguageManager.getString("Segnalazione.integrity.constraint.violation.cause"),
                ApplicationConfigurator.LanguageManager.getString("Segnalazione.integrity.constraint.violation.solution"));
        
        private final String userCategory;
        private final String userMessage;
        private final String cause;
        private final String solution;
        
        exceptionType(String userCategory, String userMessage, String cause, String solution){
            this.userCategory = userCategory;
            this.userMessage = userMessage;
            this.cause = cause;
            this.solution = solution;
        }
        
        public String userCategory() { return userCategory; }
        public String userMessage() { return userMessage; }
        public String cause() { return cause; }
        public String solution() { return solution; }

    };
    
    private Exception ExceptionObj = null;
    private ExceptionInfo() {
        //
    }

    public ExceptionInfo(Exception E) {
        this.ExceptionObj = E;
    }
    
    public String getUserCategory(){
        return this.getExceptionType().userCategory();
    }

    public String getUserMessage(){
        return this.getExceptionType().userMessage();
    }

    public String get_Cause(){
        return this.getExceptionType().cause();
    }
    
    public String getSolution(){
        return this.getExceptionType().solution();
    }
    
    public exceptionType getExceptionType(){
        return this.getExceptionType(this.ExceptionObj);
    }
    
    private exceptionType getExceptionType(Exception E){
        if (E != null){
            if (E instanceof EJBException){
                return getExceptionType(((EJBException)E).getCausedByException());
            } else {
                if (E instanceof SQLException){
                    SQLException SQLEx = ((SQLException)E);
                    if (SQLEx.getSQLState().substring(0,2).equals("23")){
                        return exceptionType.INTEGRITY_CONSTRAINT_VIOLATION;
                    } else {
                        return exceptionType.GENERIC_DATABASE_ERROR;
                    }
                } else {
                    return exceptionType.GENERIC_ERROR;
                }
            }
        } else {
            return exceptionType.NOT_DETERMINABLE;
        }
    }

    public String getDetail(){
        StackTraceElement[] Stack = this.ExceptionObj.getStackTrace();
        String result = "";
        for (int i=0; i<Stack.length; i++){
            result += Stack[i]+"<br>";
        }
        return result;
    }
    
    public String get_Message(){
        return 
                this.ExceptionObj.toString() + 
                "<br><br>" + 
                this.ExceptionObj.getLocalizedMessage(); 
    }
}
