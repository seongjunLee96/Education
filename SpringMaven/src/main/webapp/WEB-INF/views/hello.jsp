<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<style>
	#topMenu { 
		height: 30px; 
		width: 850px; 
	} 
	#topMenu ul li { 
		list-style: none;
		color: white;
		background-color: #2d2d2d; 
		float: left; 
		line-height: 30px; 
		vertical-align: middle; 
		text-align: center; 
	} 
	#topMenu .menuLink { 
		text-decoration:none; 
		color: white; 
		display: block; 
		width: 200px; 
		font-size: 12px; 
		font-weight: bold; 
		font-family: "Trebuchet MS", Dotum, Arial; 
	}
	#topMenu .menuLink:hover { 
		color: red; 
		ackground-color: #4d4d4d; 
	}
	
	#leftMenu{
		float:left;
	}
	#contents{
		float:left;
	} 
	#delete{
		float: right;
	}
	
	button{
		text-shadow: 0 1px 0 #fff;
		border-color: #ccc;
		color: white;
   		background-color: #337ab7;
		display: inline-block;
	    padding: 6px 12px;
	    margin-bottom: 0;
	    font-size: 13px;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: middle;
	    touch-action: manipulation;
	    cursor: pointer;
	    user-select: none;
	    border: 1px solid transparent;
	    border-radius: 4px;
	}
	div{
		padding: 5px 5px 5px 5px;
	}
	table#listTable {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;

	}
	table#listTable thead th {
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    color: #369;
	    border-bottom: 3px solid #036;
	}
	table#listTable tbody th {
	    width: 150px;
	    padding: 10px;
	    font-weight: bold;
	    vertical-align: top;
	    border-bottom: 1px solid #ccc;
	    background: #f3f6f7;
	}
	table#listTable td {
	    width: 350px;
	    padding: 10px;
	    vertical-align: top;
	    border-bottom: 1px solid #ccc;
	}
	table input{
		text-align : center;
	}
	table button{
		width : 100%;
	}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<body>
	<div>
		<div>
			<nav id="topMenu" > 
				<ul> 
					<li><a class="menuLink" href="/hello">List</a></li> 
				</ul> 
			</nav>
		</div>
		<div id="leftMenu">
			<ul>
				<li><a>User</a>
			</ul>
		</div>
		<div id="contents">
			<div style="">
				<input type="text" id="keyword"/>
				<button id="search">Search</button>
				<button id="add">Add</button>
				<button id="delete">Delete</button>
			</div>
			<div>
				<table id="listTable">
					<thead>
						<tr>
							<td style="width:20px"></td>
							<td>USER ID</td>
							<td>USER NAME</td>
							<td>USER DEP</td>
							<td>USER GENDER</td>
							<td>USER AGE</td>
							<td>	</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$( document ).ready( function() {
		
		$("#search").click(function(){
			var userId = $("#keyword").val();
			
			$.ajax({
	    		type:"POST",
	    		url:"/select",
	    		data: {"KEYWORD":userId},
	    		dataType:"json",
	    		error : function(){
	    			console.log("fail select");
	    		},
	    		success : function(data){
	    			var html ="";
	    			var list = data.hello; 
	    			if(list.length > 0){
	    				for(var i=0; i<list.length; i++){
	    					html += "<tr><td style='width:20px'><input type='checkbox'/></td>"+
	        						"<td>"+list[i].USER_ID+"</td>"+
	        					 	"<td><input type='text' value='"+list[i].USER_NAME+"'/></td>"+
	        						"<td><input type='text' value='"+list[i].USER_DEP+"'/></td>"+
	        						"<td><input type='text' value='"+list[i].USER_GENDER+"'/></td>"+
	        						"<td><input type='text' value='"+list[i].USER_AGE+"'/></td>"+	
	        						"<td><input type='button' value='save' onClick='javascript:onSave(this);'/></td></tr>";
	    				}
	    				$("#listTable tbody tr").remove();
	    				$("#listTable tbody").append(html);
	    			}
	    		}
	    	});
	    });
		
	    $("#add").click(function(){
	    	$("#listTable tbody").append(
	    			"<tr><td style='width:20px'></td>"+
				 	"<td><input type='text'/></td>"+"<td><input type='text'/></td>"+
					"<td><input type='text'/></td>"+"<td><input type='text'/></td>"+
					"<td><input type='text'/></td>"+"<td><input type='button' value='save' onClick='javascript:onSave(this);'/></td></tr>");
	    });
	    
	    $("#delete").click(function(){
    		var tableTrCount = $("#listTable tbody tr").length;
    		var param={};
    		if(tableTrCount > 0){
    			if(confirm("Do you want to delete?")){
    				
    				for(var iTmp=0; iTmp < tableTrCount; iTmp++){
    	    			if($("#listTable tbody tr:eq("+iTmp+") input").is(":checked")){
    	    				var userId = $("#listTable tbody tr:eq("+iTmp+") td:eq(1)").text();
    	    				param = {"USER_ID" : userId};
    	    				$.ajax({
    	    		    		type:"POST",
    	    		    		async:false,
    	    		    		url:"/remove",
    	    		    		data:param,
    	    		    		dataType:"json",
    	    		    		error : function(){
    	    		    			console.log("fail delete");
    	    		    		},
    	    		    		success : function(){
    	    		    			console.log("success delete");
    	    		    		}
    	    		    	});
    	    			}
    	    		}
    			}
    		}
    		$("#search").trigger("click");
	    });
	    
	    $("#search").trigger("click");
	    
	} );
	
	function onSave(element){
		
		var userId = $(element).parent().parent().find("td:eq(1)").text();
		var userName = $(element).parent().parent().find("input:eq(1)").val();
		var userDep = $(element).parent().parent().find("input:eq(2)").val();
		var userGender = $(element).parent().parent().find("input:eq(3)").val();
		var userAge = $(element).parent().parent().find("input:eq(4)").val();
		var url = "/update";
		
		if(userId == ""){
			userId = $(element).parent().parent().find("input:eq(0)").val();
			userName = $(element).parent().parent().find("input:eq(1)").val();
			userDep = $(element).parent().parent().find("input:eq(2)").val();
			userGender = $(element).parent().parent().find("input:eq(3)").val();
			userAge = $(element).parent().parent().find("input:eq(4)").val();
			url = "/create";
		}
		
		var param = {"USER_ID":userId, "USER_NAME":userName, "USER_DEP":userDep, "USER_GENDER":userGender, "USER_AGE":userAge}
		$.ajax({
    		type:"POST",
    		url:url,
    		data:param,
    		dataType:"json",
    		error : function(){
    			console.log("fail "+url);
    		},
    		success : function(){
    			console.log("success "+url);
    			$("#search").trigger("click");
    		}
    	});
    }
	</script>
</body>
</html>