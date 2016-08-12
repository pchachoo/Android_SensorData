<%-- 
    Document   : response2
    Created on : Aug 21, 2014, 10:38:24 PM
    Author     : Prachi
--%>

<%@page import="org.jfree.data.xy.XYDataset"%>
<%@page import="org.jfree.data.jdbc.JDBCCategoryDataset"%>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>


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
    //Clean up existing image files
    File cleanDir = new File("C:/ECE/SensorDataDisplay/web/images");
    if(cleanDir.exists() && cleanDir.isDirectory())
    {
        File[] images = cleanDir.listFiles();
        for (int i=0; i<images.length; i++)
        {
            images[i].delete();
        }
    }

    
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
    String lname = request.getParameter("labelname");
    String starttime = request.getParameter("startTime");    
    String endtime = request.getParameter("endTime");
    String startdate = request.getParameter("startDate");
    String enddate = request.getParameter("endDate");
      
      
    String sql =  null;
    
  //Preparing SQL statement for Accelerometer data

   if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Timestamp,acc_x,acc_y,acc_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"' and label = '" + lname +"'";
    }
    else
    {
        sql = "SELECT Timestamp, acc_x,acc_y,acc_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"' and label = '" + lname +"'";            
    }
   
    //System.out.println(sql);
    java.sql.PreparedStatement pstmt =  myConn.prepareStatement(sql);
    
    java.sql.ResultSet rs = pstmt.executeQuery();
   /* 
    java.util.ArrayList accx = new ArrayList();
    java.util.ArrayList accy = new ArrayList();
    java.util.ArrayList accz = new ArrayList();
    
    if (rs != null) {
    try {
      while(rs.next()){
        accx.add(new Double(rs.getDouble("Acc_x")));
        accy.add(new Double(rs.getDouble("Acc_y")));
        accz.add(new Double(rs.getDouble("Acc_z")));
      }
     
      rs.close();
      } catch (java.sql.SQLException e) { throw e;}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { throw e;}
    }
*/
    
    JDBCCategoryDataset jdbcSet = new JDBCCategoryDataset(myConn,sql);
    JFreeChart jChart = null; 
    
    LineAndShapeRenderer renderer = null;
    CategoryPlot cplot = null;
    
    CategoryAxis categoryAxis = new CategoryAxis("Time");
    categoryAxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
    
    ValueAxis valueAxis = new org.jfree.chart.axis.NumberAxis("Accelerometer Data");

    renderer = new  LineAndShapeRenderer();
    
    cplot = new CategoryPlot(jdbcSet, categoryAxis, valueAxis, renderer);
    cplot.setOrientation(PlotOrientation.VERTICAL);
    jChart = new JFreeChart("Accelerometer", JFreeChart.DEFAULT_TITLE_FONT, cplot, true);

    jChart.setBackgroundPaint(new Color(249, 231, 236));

    Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));

    renderer.setSeriesPaint(1, p1);

    Paint p2 = new GradientPaint(0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));

    renderer.setSeriesPaint(2, p2);

    cplot.setRenderer(renderer);
    
    try{
        ChartUtilities.saveChartAsJPEG(new File("C:/ECE/SensorDataDisplay/web/images/Acc_chart.jpg"), jChart, 1024, 768);
    }catch (IOException e){
        System.out.println("ECE Project....Problem in creating chart.");
    }
    
    
  //Preparing SQL statement for GPS data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Timestamp,GPS_lat,GPS_long,GPS_Speed from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Timestamp,GPS_lat,GPS_long,GPS_Speed from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    jdbcSet = new JDBCCategoryDataset(myConn,sql);
    jChart = null; 
    
    renderer = null;
    cplot = null;
    
    categoryAxis = new CategoryAxis("Time");
    categoryAxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
    
    valueAxis = new org.jfree.chart.axis.NumberAxis("GPS Data");

    renderer = new  LineAndShapeRenderer();
    
    cplot = new CategoryPlot(jdbcSet, categoryAxis, valueAxis, renderer);
    cplot.setOrientation(PlotOrientation.VERTICAL);
    jChart = new JFreeChart("GPS", JFreeChart.DEFAULT_TITLE_FONT, cplot, true);

    jChart.setBackgroundPaint(new Color(249, 231, 236));

    p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));

    renderer.setSeriesPaint(1, p1);

    p2 = new GradientPaint(0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));

    renderer.setSeriesPaint(2, p2);

    cplot.setRenderer(renderer);
    
    try{
        ChartUtilities.saveChartAsJPEG(new File("C:/ECE/SensorDataDisplay/web/images/GPS_chart.jpg"), jChart, 1024, 768);
    }catch (IOException e){
        System.out.println("ECE Project....Problem in creating GPS chart.");
    }
 /*   pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList GPSlat = new ArrayList();
    java.util.ArrayList GPSlong = new ArrayList();
    java.util.ArrayList GPSSpeed = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        GPSlat.add(new Double(rs.getDouble("GPS_lat")));
        GPSlong.add(new Double(rs.getDouble("GPS_long")));
        GPSSpeed.add(new Double(rs.getDouble("GPS_Speed")));
      }
  
      rs.close();
      } catch (java.sql.SQLException e) { throw e}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { throw e}
    }
*/
    
    
    
  //Preparing SQL statement for Magnetometer data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Timestamp,Mag_x,Mag_y,Mag_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Timestamp,Mag_x,Mag_y,Mag_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    
    jdbcSet = new JDBCCategoryDataset(myConn,sql);
    jChart = null; 
    
    renderer = null;
    cplot = null;
    
    categoryAxis = new CategoryAxis("Time");
    categoryAxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
    
    valueAxis = new org.jfree.chart.axis.NumberAxis("Magnetometer Data");

    renderer = new  LineAndShapeRenderer();
    
    cplot = new CategoryPlot(jdbcSet, categoryAxis, valueAxis, renderer);
    cplot.setOrientation(PlotOrientation.VERTICAL);
    jChart = new JFreeChart("Magnetometer", JFreeChart.DEFAULT_TITLE_FONT, cplot, true);

    jChart.setBackgroundPaint(new Color(249, 231, 236));

    p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));

    renderer.setSeriesPaint(1, p1);

    p2 = new GradientPaint(0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));

    renderer.setSeriesPaint(2, p2);

    cplot.setRenderer(renderer);
    
    try{
        ChartUtilities.saveChartAsJPEG(new File("C:/ECE/SensorDataDisplay/web/images/Mag_chart.jpg"), jChart, 1024, 768);
    }catch (IOException e){
        System.out.println("ECE Project....Problem in creating Mag chart.");
    }
    
 /*   pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList Magx = new ArrayList();
    java.util.ArrayList Magy = new ArrayList();
    java.util.ArrayList Magz = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        Magx.add(new Double(rs.getDouble("Mag_x")));
        Magy.add(new Double(rs.getDouble("Mag_y")));
        Magz.add(new Double(rs.getDouble("Mag_z")));
      }
    
      rs.close();
      } catch (java.sql.SQLException e) { throw e;}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { throw e;}
    }
  */  
  //Preparing SQL statement for Gyroscope data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Timestamp,Gyro_x,Gyro_y,Gyro_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Timestamp,Gyro_x,Gyro_y,Gyro_z from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
    }
    jdbcSet = new JDBCCategoryDataset(myConn,sql);
    jChart = null; 
    
    renderer = null;
    cplot = null;
    
    categoryAxis = new CategoryAxis("Time");
    categoryAxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
    
    valueAxis = new org.jfree.chart.axis.NumberAxis("Gyroscope Data");

    renderer = new  LineAndShapeRenderer();
    
    cplot = new CategoryPlot(jdbcSet, categoryAxis, valueAxis, renderer);
    cplot.setOrientation(PlotOrientation.VERTICAL);
    jChart = new JFreeChart("Gyroscope", JFreeChart.DEFAULT_TITLE_FONT, cplot, true);

    jChart.setBackgroundPaint(new Color(249, 231, 236));

    p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));

    renderer.setSeriesPaint(1, p1);

    p2 = new GradientPaint(0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));

    renderer.setSeriesPaint(2, p2);

    cplot.setRenderer(renderer);
    
    try{
        ChartUtilities.saveChartAsJPEG(new File("C:/ECE/SensorDataDisplay/web/images/Gyro_chart.jpg"), jChart, 1024, 768);
    }catch (IOException e){
        System.out.println("ECE Project....Problem in creating Gyroscope chart.");
    }    
 /*
    pstmt =  myConn.prepareStatement(sql);
    
    rs = pstmt.executeQuery();
    
    java.util.ArrayList Gyrox = new ArrayList();
    java.util.ArrayList Gyroy = new ArrayList();
    java.util.ArrayList Gyroz = new ArrayList();
    
    if (rs != null) {
    try {
 
      while(rs.next()){
        Gyrox.add(new Double(rs.getDouble("Gyro_x")));
        Gyroy.add(new Double(rs.getDouble("Gyro_y")));
        Gyroz.add(new Double(rs.getDouble("Gyro_z")));
      }
 
      rs.close();
      } catch (java.sql.SQLException e) {throw e;}
    }
          
    if (pstmt != null) {
    try {
            pstmt.close();
        } catch (java.sql.SQLException e) { throw e;}
    }
*/
    //Preparing SQL statement for WiFi SSIDs, Cell tower ID data
    if((enddate.isEmpty()) || (endtime.isEmpty()))
    {
        sql = "SELECT Timestamp,WiFiSSID1,WiFiSSID2,CellTwrID  from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and projectname = '" + pname +"' and username = '" + uname +"'";
    }
    else
    {
        sql = "SELECT Timestamp,WiFiSSID1,WiFiSSID2,CellTwrID  from sensor_data where Timestamp >= '" + startdate + ' ' + starttime +"' and Timestamp < '" + enddate + ' ' + endtime +"' and projectname = '" + pname +"' and username = '" + uname +"'";            
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
           
        <IMG SRC="images/Acc_chart.jpg" WIDTH="1024" 
  HEIGHT="625" BORDER="1" USEMAP="#chart">
        
        <hr>
        
         <IMG SRC="images/GPS_chart.jpg" WIDTH="1024" 
  HEIGHT="625" BORDER="1" USEMAP="#chart">
         
         <hr>
          <IMG SRC="images/Mag_chart.jpg" WIDTH="1024" 
  HEIGHT="625" BORDER="1" USEMAP="#chart">
          <hr> 
           <IMG SRC="images/Gyro_chart.jpg" WIDTH="1024" 
  HEIGHT="625" BORDER="1" USEMAP="#chart">
        

    </body>
</html>
