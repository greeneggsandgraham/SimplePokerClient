<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ page import="com.poker.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
Date d = new Date(session.getLastAccessedTime());
PokerRunner pr = new PokerRunner();

Deck deck = pr.init();
Hand myHand = pr.getHand(deck);

Iterator<Card> handIter = myHand.getCards().iterator();

Card card = null;
%>
<title>Simple JSP</title>
        <style>
            body {
                margin: 1px;
                padding: 1px;
            }
            
            #PlayingTable {
                border: 1px solid #9C9898;
                background: #360;
            }
        </style>
		<script SRC="javascript/CardFunctions.js" ></script>
		<script SRC="javascript/jquery/jquery-1.7.2.js" ></script>
        <script>
            
            var canvas = null;
            var context = null;
            
            window.onload = function(){
                canvas = document.getElementById("PlayingTable");
                context = canvas.getContext("2d");
                
            };
            
            var getNewCards = function(){
            	//Erases the canvas
            	canvas.width = canvas.width;
            	
            	$.get("response/PokerClientResponse", function(data){
            			$.each(data, function(index, value) { 
            				if($.isArray(value)){
            			  		var x = 10;
            			  		$.each(value, function(i, cardObj){
            			  			CardFunctions.drawCard(x, 150, cardObj.Value, cardObj.Suit);
            			  			x += 55;
            			  		});
            			  	} else {
            			  		CardFunctions.drawText(10, 250, value.HandValue);
            			  	}
            				 
            			});
            		});
            };
						
        </script>
        
</head>
<body>

<canvas id="PlayingTable" width="600" height="250">
        </canvas>
<br>
<input type="button" id="dealButton" value="Deal" onclick="getNewCards()" /> 
</body>
</html>