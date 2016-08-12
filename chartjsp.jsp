<%-- 
    Document   : chartjsp
    Created on : Aug 22, 2014, 12:01:44 PM
    Author     : Prachi
--%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Charts</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
    <%      Platform.runLater(new Runnable() {
             @Override
             public void run() {
        javafx.scene.Group root = new javafx.scene.Group();
              
        javafx.stage.Stage primaryStage = null;
        primaryStage.setScene(new javafx.scene.Scene(root));
        NumberAxis xAxis = new NumberAxis("Values for X-Axis", 0, 3, 1);
        NumberAxis yAxis = new NumberAxis("Values for Y-Axis", 0, 3, 1);
        ObservableList<javafx.scene.chart.XYChart.Series<Double,Double>> lineChartData = FXCollections.observableArrayList(
            new LineChart.Series<Double,Double>("Series a", FXCollections.observableArrayList(
                new XYChart.Data<Double,Double>(0.0, 1.0),
                new XYChart.Data<Double,Double>(1.2, 1.4),
                new XYChart.Data<Double,Double>(2.2, 1.9),
                new XYChart.Data<Double,Double>(2.7, 2.3),
                new XYChart.Data<Double,Double>(2.9, 0.5)
            )),
            new LineChart.Series<Double,Double>("Series 2", FXCollections.observableArrayList(
                new XYChart.Data<Double,Double>(0.0, 1.6),
                new XYChart.Data<Double,Double>(0.8, 0.4),
                new XYChart.Data<Double,Double>(1.4, 2.9),
                new XYChart.Data<Double,Double>(2.1, 1.3),
                new XYChart.Data<Double,Double>(2.6, 0.9)
            ))
        );
        LineChart chart = new LineChart(xAxis, yAxis, lineChartData);
        root.getChildren().add(chart);
             }
    //@Override public void start(Stage primaryStage) throws Exception {
       // init(primaryStage);
       // primaryStage.show();



        %>
</html>
