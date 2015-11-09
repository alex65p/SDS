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

package s2s.utils;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
import java.util.*;
import java.text.*;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.mail.MailChecker;

//===================================================================
//-------------------Errors classes----------------------------------
//===================================================================
class Error {

    protected String m_Message = new String();
    protected String m_Description = new String();

    public Error() {
    }

    public void setMessage(String newMessage) {
        m_Message = newMessage;
    }

    public String getMessage() {
        if (m_Description != null) {
            return m_Message + " - " + m_Description;
        } else {
            return m_Message;
        }
    }

    public void setDescription(String newDescr) {
        m_Description = newDescr;
    }

    public String getDescription() {
        return m_Description;
    }
}
//-------------------------------------------------------------------
class RequiredError extends Error {

    public RequiredError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("è.obbligatorio");
    }
}
//-------------------------------------------------------------------
class NotNumberError extends Error {

    public NotNumberError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("deve.essere.un.numero");
    }
}
//-------------------------------------------------------------------
class NotStringError extends Error {

    public NotStringError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("deve.essere.una.stringa");
    }
}
//-------------------------------------------------------------------
class NotDateError extends Error {

    private String datePattern = new String("[dd/MM/yyyy]");

    public NotDateError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("deve.essere.in.formato.data") +
                " - " + datePattern;
    }

    public void setPattern(String newPattern) {
        datePattern = newPattern;
    }

    public String getPattern() {
        return datePattern;
    }
}

class NotEmailError extends Error {

    public NotEmailError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("deve.essere.nel.formato.indirizzo.dominio");
    }
}

class EmptySpaceError extends Error {

    public EmptySpaceError(String strObjName) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                ApplicationConfigurator.LanguageManager.getString("No.spazi.bianchi");
    }
}

class CustomError extends Error {

    public CustomError(String strObjName, String errorMessage) {
        m_Message = ApplicationConfigurator.LanguageManager.getString("Il.campo") +
                " '" + strObjName + "' " +
                errorMessage;
    }
}

//=============================================================================
//--------------------Class Checker--------------------------------------------
//=============================================================================
public class Checker {

    private Collection errors;
    public boolean isError;
    private String datePattern = new String("dd/MM/yyyy");
    public int year_local;
    private String genericNumberException =
            ApplicationConfigurator.LanguageManager.getString("errore.numerico.generico");

    // constructor
    public Checker() {
        errors = new java.util.ArrayList();
    }

    //<chekers-for-search>
    public Short checkShortEx(String strObjName, String str, boolean bReq) {
        if (str == null || str.equals("")) {
            return null;
        }
        return new Short(checkShort(strObjName, str, false));
    }

    public Integer checkIntEx(String strObjName, String str, boolean bReq) {
        if (str == null || str.equals("")) {
            return null;
        }
        return new Integer(checkInt(strObjName, str, false));
    }

    public Float checkFloatEx(String strObjName, String str, boolean bReq) {
        if (str == null || str.equals("")) {
            return null;
        }
        return new Float(checkFloat(strObjName, str, false));
    }

    public Long checkLongEx(String strObjName, String str, boolean bReq) {
        if (str == null || str.equals("")) {
            return null;
        }
        return new Long(checkLong(strObjName, str, false));
    }

    public String checkStringEx(String strObjName, String str, boolean bReq) {
        if (str == null || str.equals("")) {
            return null;
        }
        return checkString(strObjName, str, false).toUpperCase() + "%";
    }
    //</chekers-for-search>
    // check String
    public String checkString(String strObjName, String str, boolean bReq) {
        if (str != null) {
            if (bReq && str.equals("")) {
                errors.add(new RequiredError(strObjName));
                if (!isError) {
                    isError = true;
                }
                return new String();
            }
            return str;
        }
        return new String();
    }

    // check Email
    public String checkEmail(String strObjName, String str, boolean bReq) {
        if (bReq) {
            if (str == null || str.trim().equals("")) {
                errors.add(new RequiredError(strObjName));
                if (!isError) {
                    isError = true;
                }
                return null;
            }
        }
        if (str != null && !str.trim().equals("")) {
            MailChecker CheckMail = new MailChecker();
            if (!CheckMail.isValidEmailAddress(str)) {
                NotEmailError err = new NotEmailError(strObjName);
                errors.add(err);
                if (!isError) {
                    isError = true;
                }
                return null;
            }
        }
        return str;
    }
    
    public String checkEmptySpaces(String strObjName, String str, boolean bReq) {
        if (str != null) {
            if (bReq && str.indexOf(" ") > -1) {
                errors.add(new EmptySpaceError(strObjName));
                if (!isError) {
                    isError = true;
                }
                return new String();
            }
            return str;
        }
        return new String();
    }

        // check Long
    public long checkNoZeroLong(String strObjName, String str, boolean bReq) {
        long lvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("") || str.equals("0")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    lvar = Long.parseLong(str);
                    return lvar;
                }
            } else if (bReq) {
                errors.add(new RequiredError(strObjName));
                if (!isError) {
                    isError = true;
                }
                return 0;
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }
        return 0;
    }


    // check Long
    public long checkLong(String strObjName, String str, boolean bReq) {
        long lvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    lvar = Long.parseLong(str);
                    return lvar;
                }
            } else if (bReq) {
                errors.add(new RequiredError(strObjName));
                if (!isError) {
                    isError = true;
                }
                return 0;
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return 0;
    }

    // check Double
    public double checkDouble(String strObjName, String str, boolean bReq) {
        double dvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    dvar = Double.parseDouble(str);
                    return dvar;
                }
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return 0;
    }

    // check Float
    public float checkFloat(String strObjName, String str, boolean bReq) {
        float dvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    dvar = Float.parseFloat(str);
                    return dvar;
                }
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return 0;
    }

    // check Float
    public short checkShort(String strObjName, String str, boolean bReq) {
        short dvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    dvar = Short.parseShort(str);
                    return dvar;
                }
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return 0;
    }

    // check Int
    public int checkInt(String strObjName, String str, boolean bReq) {
        int dvar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return 0;
                    }
                }
                if (!str.equals("")) {
                    dvar = Integer.parseInt(str);
                    return dvar;
                }
            }
            return 0;
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(this.genericNumberException + ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return 0;
    }

    //---------------------------------------------------------------------
    public String checkTime(String strObjName, String str, boolean bReq) {
        long tHourVar;
        long tMinVar;
        try {
            if (str != null) {
                if (bReq) {
                    if (str.equals("")) {
                        errors.add(new RequiredError(strObjName));
                        if (!isError) {
                            isError = true;
                        }
                        return new String();
                    }
                }
                if (!str.equals("")) {
                    tHourVar = Long.parseLong(str.substring(0, 2));
                    tMinVar = Long.parseLong(str.substring(3, 5));
                    if (tHourVar < 0 || tHourVar > 23) {
                        throw new Exception(ApplicationConfigurator.LanguageManager.getString("le.ore.devono.essere.comprese.tra.0.e.23"));
                    }
                    if (tMinVar < 0 || tMinVar > 59) {
                        throw new Exception(ApplicationConfigurator.LanguageManager.getString("i.minuti.devono.essere.compresi.tra.0.e.59"));
                    }
                    return str;
                }
            }
            return new String();
        } catch (NumberFormatException NumEx) {
            NotNumberError err = new NotNumberError(strObjName);
            err.setDescription(NumEx.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(ApplicationConfigurator.LanguageManager.getString("errore.di.orario.generico") +
                    ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }

        return new String();
    }

    // check java.sql.Date
    public java.sql.Date checkDate(String strObjName, String str, boolean bReq) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(datePattern);
        try {
            if (bReq) {
                if (str.equals("") || str == null) {
                    errors.add(new RequiredError(strObjName));
                    if (!isError) {
                        isError = true;
                    }
                    return null;
                }

            }
            //else{
            if (str != null && !str.equals("")) {
                Calendar cal = dateFormat.getCalendar();
                dateFormat.setLenient(false);
                java.util.Date date = dateFormat.parse(str);
                int year = cal.get(Calendar.YEAR); // date.getYear();
                year_local = cal.get(Calendar.YEAR);
                if (year_local > 9999 || year_local < 1900) {
                    NotDateError err = new NotDateError(strObjName);
                    errors.add(err);
                    err.setDescription(
                            ApplicationConfigurator.LanguageManager.getString("anno.deve.essere.maggiore.di.1900.e.minore.di.9999"));
                    if (!isError) {
                        isError = true;
                    }
                    return null;
                }
                int month = cal.get(Calendar.MONTH); //date.getMonth();
                int day = cal.get(Calendar.DAY_OF_MONTH); //date.getDate();
                //java.sql.Date date_sql = new java.sql.Date(year,month,day);
                java.sql.Date date_sql = new java.sql.Date(cal.getTimeInMillis());
                return date_sql;
            }
        //}
        } catch (ParseException e) {
            NotDateError err = new NotDateError(strObjName);
            //err.setDescription(e.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(
                    ApplicationConfigurator.LanguageManager.getString("errore.di.data.generico") +
                    ": '" + strObjName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }
        return null;
    }

    public String checkTrigger(String objName, String str, String[] base) {
        String YES = new String();
        String NO = new String();
        String trigger = new String();
        try {
            if (base != null) {
                YES = base[1];
                NO = base[0];
            }
            if (str.equals(YES)) {
                trigger = YES;
            } else {
                trigger = NO;
            }
        } catch (java.lang.ArrayIndexOutOfBoundsException ex) {
            Error err = new Error();
            err.setMessage(
                    ApplicationConfigurator.LanguageManager.getString("errore.di.trigger.a.i.o.o.b") +
                    ": '" + objName + "'");
            err.setDescription(ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(
                    ApplicationConfigurator.LanguageManager.getString("errore.di.trigger.generico.per") +
                    ": '" + objName + "' - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }
        return trigger;
    }

    public String checkTrigger(String objName, String str) {
        String YES = new String("S");
        String NO = new String("N");
        String trigger = new String();
        try {
            if (str != null) {
                trigger = YES;
            } else {
                trigger = NO;
            }
        } catch (Exception ex) {
            Error err = new Error();
            err.setMessage(
                    ApplicationConfigurator.LanguageManager.getString("errore.di.trigger.generico") +
                    " - " + ex.getMessage());
            errors.add(err);
            if (!isError) {
                isError = true;
            }
        }
        return trigger;
    }

    public void addCustomError(String strObjName, String str){
        errors.add(new CustomError(strObjName, str));
        if (!isError) {
            isError = true;
        }
    }
    
    // getErrors
    public Collection getErrors() {
        return errors;
    }

    // Print Errors
    public String printErrors() {
        String str = new String();
        java.util.Iterator it = errors.iterator();
        while (it.hasNext()) {
            Error err = (Error) it.next();
            str += err.getMessage() + "\\n";
        }
        str = str.replace('\"', '\'');
        return str;
    }

    // set/getPattern
    public void setPattern(String newPattern) {
        datePattern = newPattern;
    }

    public String getPattern() {
        return datePattern;
    }

    public java.util.Iterator checkALong(String strName, String _enum[]) {
        return checkAlLong(strName, _enum).iterator();
    }

    public java.util.ArrayList checkAlLong(String strName, String _enum[]) {
        java.util.ArrayList array = new java.util.ArrayList();
        if (_enum == null) {
            return array;
        }

        for (int i = 0; i < _enum.length; i++) {
            long l = this.checkLong(strName, _enum[i], false);
            array.add(new Long(l));
        }
        return array;
    }
}
