<%-- 
    Document   : response2
    Created on : Aug 21, 2014, 10:38:24 PM
    Author     : Prachi
--%>



<%@page import="javafx.beans.DefaultProperty"%>
<%@page import="javafx.beans.property.BooleanProperty"%>
<%@page import="javafx.collections.ObservableList"%>

<%@page import = "javafx.application.Application"%>
<%@page import = " javafx.collections.FXCollections"%>
<%@page import = " javafx.collections.ObservableList"%>
<%@page import= " javafx.scene.Group"%>
<%@page import = " javafx.scene.Scene"%>
<%@page import = " javafx.scene.chart.LineChart"%>
<%@page import = " javafx.scene.chart.NumberAxis"%>
<%@page import = " javafx.scene.chart.XYChart"%>
<%@page import = " javafx.stage.Stage"%>
<%@page import = " javafx.application.Platform"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  
    java.sql.Connection myConn = null ;
    java.util.Properties connectionProps = new Properties();
    connectionProps.put("user", "root");
    connectionProps.put("password", "root");

    myConn = DriverManager.getConnection(
    "jdbc:mysql://127.0.0.1:3306/rawsensorinputs?zeroDateTimeBehavior=convertToNull",
                   connectionProps);
   
    System.out.println("Connected to database(RawSensorInputs)");
    
    String uname = request.getParameter("username");
    String pname = request.getParameter("projectname");
    
    String starttime = request.getParameter("startTime");    
    String endtime = request.getParameter("endTime");
    String startdate = request.getParameter("startDate");
    String enddate = request.getParameter("endDate");
      
      
    String sql =  null;
  //Preparing SQL statement for Accelerometer data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT acc_x,acc_y,acc_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT acc_x,acc_y,acc_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    
    java.sql.PreparedStatement pstmt =  myConn.prepareStatement(sql);
    
    java.sql.ResultSet rs = pstmt.executeQuery();
    
    java.util.ArrayList accx = new ArrayList();
    java.util.ArrayList accy = new ArrayList();
    java.util.ArrayList accz = new ArrayList();
    
    if (rs != null) {
    try {
    //Float f = rs.getFloat("Acc_x");
      while(rs.next()){
        accx.add(new Float(rs.getFloat("Acc_x")));
        accy.add(new Float(rs.getFloat("Acc_y")));
        accz.add(new Float(rs.getFloat("Acc_z")));
      }
     
      rs.close();
      } catch (java.sql.SQLException e) { /* ignored */}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }

  //Preparing SQL statement for GPS data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT GPS_lat,GPS_long,GPS_Speed from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT GPS_lat,GPS_long,GPS_Speed from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    
    pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList GPSlat = new ArrayList();
    java.util.ArrayList GPSlong = new ArrayList();
    java.util.ArrayList GPSSpeed = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        GPSlat.add(new Float(rs.getFloat("GPS_lat")));
        GPSlong.add(new Float(rs.getFloat("GPS_long")));
        GPSSpeed.add(new Float(rs.getFloat("GPS_Speed")));
      }
  
      rs.close();
      } catch (java.sql.SQLException e) { /* ignored */}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }

  //Preparing SQL statement for Magnetometer data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Mag_x,Mag_y,Mag_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Mag_x,Mag_y,Mag_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    
    pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList Magx = new ArrayList();
    java.util.ArrayList Magy = new ArrayList();
    java.util.ArrayList Magz = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        Magx.add(new Float(rs.getFloat("Mag_x")));
        Magy.add(new Float(rs.getFloat("Mag_y")));
        Magz.add(new Float(rs.getFloat("Mag_z")));
      }
    
      rs.close();
      } catch (java.sql.SQLException e) { /* ignored */}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }
    
  //Preparing SQL statement for Gyroscope data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Gyro_x,Gyro_y,Gyro_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Gyro_x,Gyro_y,Gyro_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList Gyrox = new ArrayList();
    java.util.ArrayList Gyroy = new ArrayList();
    java.util.ArrayList Gyroz = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        Gyrox.add(new Float(rs.getFloat("Gyro_x")));
        Gyroy.add(new Float(rs.getFloat("Gyro_y")));
        Gyroz.add(new Float(rs.getFloat("Gyro_z")));
      }
 
      rs.close();
      } catch (java.sql.SQLException e) { /* ignored */}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }

    //Preparing SQL statement for WiFi SSIDs, Cell tower ID data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT WiFiSSID1,WiFiSSID2,CellTwrID  from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT WiFiSSID1,WiFiSSID2,CellTwrID  from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    
    pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList WiFi_SSID1 = new ArrayList();
    java.util.ArrayList WiFi_SSID2 = new ArrayList();
    java.util.ArrayList CellTwr_ID = new ArrayList();
   
    if (rs != null) {
    try {
 
      while(rs.next()){
        WiFi_SSID1.add(new String(rs.getString("WiFiSSID1")));
        WiFi_SSID2.add(new String(rs.getString("WiFiSSID2")));
        CellTwr_ID.add(new Integer(rs.getInt("CellTwrID")));
        
      }
     
      rs.close();
      } catch (java.sql.SQLException e) { /* ignored */}
    }
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }


    if (myConn != null) {
        try {
            myConn.close();
        } catch (java.sql.SQLException e) { /* ignored */}
    }
    
   

%>


   
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CHARTS</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
