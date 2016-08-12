/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Types;
import java.util.Calendar;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Prachi
 */
public class UpdateSensorData extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateSensorData</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSensorData at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            // get JDBC Connection.
            Connection conn = null;
            String username = null;
            String projectname = null;
            String timestamp = null;
            String label = null;
            String acc_x = null;
            String acc_y = null;
            String acc_z = null;
            String gyro_x = null;
            String gyro_y = null;
            String gyro_z = null;
            String mag_x = null;
            String mag_y = null;
            String mag_z = null;
            String gps_lat = null;
            String gps_long = null;
            String gps_speed = null;
            String wiFiSSID1 = null;
            String wiFiSSID2 = null;
            String cellTwrID = null;
            String atmPressure = null;
            String micData = null;

            try
            {
                conn = getJDBCConnection();
            }catch(Exception e)
            {
                //throw e;
            }
            if (conn!= null){
               try{// Read parameters
                username = request.getParameter("username");
                projectname = request.getParameter("projectname");
                timestamp = request.getParameter("timestamp");
                label = request.getParameter("label");
                acc_x = request.getParameter("acc_x");
                acc_y = request.getParameter("acc_y");
                acc_z = request.getParameter("acc_z");
                gyro_x = request.getParameter("gyro_x");
                gyro_y = request.getParameter("gyro_y");
                gyro_z = request.getParameter("gyro_z");
                mag_x = request.getParameter("mag_x");
                mag_y = request.getParameter("mag_y");
                mag_z = request.getParameter("mag_z");
                gps_lat = request.getParameter("gps_lat");
                gps_long = request.getParameter("gps_long");
                gps_speed = request.getParameter("gps_speed");
                wiFiSSID1 = request.getParameter("wiFiSSID1");
                wiFiSSID2 = request.getParameter("wiFiSSID2");
                cellTwrID = request.getParameter("cellTwrID");
                atmPressure = request.getParameter("atmPressure");
                micData = request.getParameter("micData");
                
                //Create Insert Statement
                String insQuery = "INSERT INTO SENSOR_DATA(username ,projectname ,timestamp ,label ,acc_x ,acc_y ,acc_z ,gyro_x ,gyro_y ,gyro_z ,mag_x ,mag_y ,mag_z ,gps_lat ,gps_long ,gps_Speed ,wiFiSSID1 ,wiFiSSID2 ,cellTwrID ,atmPressure ,micData)"
                        + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        
               
                 PreparedStatement pstmt = conn.prepareStatement(insQuery);
                 pstmt.setString(1, username);
                 pstmt.setString(2, projectname);
                 pstmt.setDate(3,new java.sql.Date(Calendar.getInstance().getTime().getTime())); //timestamp
                 pstmt.setString(4, label);
                 
                 if(acc_x==null || acc_x.equals("")){
                     pstmt.setNull(5, Types.NULL);
                 }else{
                    pstmt.setDouble(5, Double.valueOf(acc_x).doubleValue());
                 }
                 pstmt.setDouble(6, Double.valueOf(acc_y).doubleValue());
                 pstmt.setDouble(7, Double.valueOf(acc_z).doubleValue());
                 pstmt.setDouble(8, Double.valueOf(gyro_x).doubleValue());
                 pstmt.setDouble(9, Double.valueOf(gyro_y).doubleValue());
                 pstmt.setDouble(10, Double.valueOf(gyro_z).doubleValue());
                 
                 pstmt.setDouble(11, Double.valueOf(mag_x).doubleValue());
                 pstmt.setDouble(12, Double.valueOf(mag_y).doubleValue());
                 pstmt.setDouble(13, Double.valueOf(mag_z).doubleValue());
                 pstmt.setDouble(14, Double.valueOf(gps_lat).doubleValue());
                 pstmt.setDouble(15, Double.valueOf(gps_long).doubleValue());
                 
                 pstmt.setDouble(16, Double.valueOf(gps_speed).doubleValue());
                 pstmt.setString(17, wiFiSSID1);
                 pstmt.setString(18, wiFiSSID2);
                 pstmt.setInt(19, Integer.valueOf(cellTwrID).intValue());
                 pstmt.setDouble(20, Double.valueOf(atmPressure).doubleValue());
                 
                 
                 Blob micBlob = conn.createBlob();
                 micBlob.setBytes(0, micData.getBytes());
                 pstmt.setBlob(21, micBlob );
                 
                 pstmt.executeQuery(insQuery);
                 
                 System.out.println ("Inserted Data: " + username +" , "+ projectname +" , "+ timestamp +" , "+ label +" , "+ acc_x +" , "+ acc_y +" , "+ acc_z +" , "+ gyro_x +" , "+ gyro_y +" , "+ gyro_z +" , "+ mag_x +" , "+ mag_y +" , "+ mag_z +" , "+ gps_lat +" , "+ gps_long +" , "+ gps_speed +" , "+ wiFiSSID1 +" , "+ wiFiSSID2 +" , "+ cellTwrID +" , "+ atmPressure +" , "+ micData);
                         
                 pstmt.close();
                 System.out.println ("Statement Closed");
                 conn.close();
                 System.out.println ("Connection Closed");
               }catch (Exception e)
               {
                   //throw e;
               }
            } //End if conn != null
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
    private Connection getJDBCConnection() throws Exception
    {
    java.sql.Connection myConn = null ;
    java.util.Properties connectionProps = new Properties();
    connectionProps.put("user", "root");
    connectionProps.put("password", "root");

        try {
            myConn = DriverManager.getConnection(
                    "jdbc:mysql://127.0.0.1:3306/rawsensorinputs?zeroDateTimeBehavior=convertToNull",
                    connectionProps);

            System.out.println("From Servlet: Connected to database(RawSensorInputs)");
        } catch (Exception e) {
            System.out.println("From Servlet: Cannot Connect to database(RawSensorInputs)");
            throw e;
        }
        return myConn;
    }    
            
}
