<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
	text-decoration: none;
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

#leftMenu {
	float: left;
}

#contents {
	float: left;
}

#delete {
	float: right;
}

button {
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

div {
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

table input {
	text-align: center;
}

table button {
	width: 100%;
}
</style>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<body>
	<div>
		<div>
			<nav id="topMenu">
			<ul>
				<li><a class="menuLink" href="/">HOME</a></li>
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
				<input type="text" id="keyword" />
				<button id="search">Search</button>
				<button id="add">Add</button>
				<button id="delete">Delete</button>
				<button id="seongjun">list</button>
			</div>
			<div>
				<table id="listTable">
					<thead>
						<tr>
							<td style="width: 20px"></td>
							<td>ID</td>
							<td>NAME</td>
							<td>AGE</td>
							<td>PHONE_NUM</td>
							<td>EMAIL</td>
							<td>ADDRESS</td>
							<td></td>
						</tr>
						<tr>
							<c:forEach var="i" items="${h}">
								${h}
							</c:forEach>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer"
		style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
			id="btnCloseLayer"
			style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
			onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

	<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }

    $( document ).ready( function() {
		
		$("#seongjun").click(function(){
			$.ajax({
				type:"POST",
				url:"/select",
				dataType:"json",
				success: function(data){
					var html = "";
					var list = data.hello; 
	    			if(list.length > 0){
	    				for(var i=0; i<list.length; i++){
	    					html += "<tr><td style='width:20px'><input type='checkbox'/></td>" + "<td>" + list[i].ID+ "</td>"
	    					+ "<td><input type='text' value='" + list[i].NAME + "'/></td>"
	    					+ "<td><input type='text' value='" + list[i].AGE + "'/></td>"
	    					+ "<td><input type='text' value='" + list[i].PHONE_NUM + "'/></td>"
	    					+ "<td><input type='email' value='" + list[i].EMAIL + "'/></td>"
	    					+ "<td><input type='text' onclick=\"sample2_execDaumPostcode()\" id=\"sample2_address\" placeholder=\"주소\" value='" + list[i].ADDRESS + "'/></td>"
	    					+ "<td><input type='text' value='save' onClick='javascript:onSave(this);'/></td></tr>";
	    				}
	    				$("#listTable tbody tr").remove();
	    				$("#listTable tbody").append(html);
	    			}
				}
			});
		});
		
		
		
		$("#search").click(function(){
			var userId = $("#keyword").val();
			
			$.ajax({
	    		type:"POST",
	    		url:"/select",
	    		data: {"KEYWORD":userId},
	    		dataType:"json",
	    		error : function(){
	    			console.log("failed select");
	    		},
	    		success : function(data){
	    			var html ="";
	    			var list = data.hello; 
	    			if(list.length > 0){
	    				for(var i=0; i<list.length; i++){
	    					html += "<tr><td style='width:20px'><input type='checkbox'/></td>"+
	        						"<td>"+list[i].ID+"</td>"+
	        					 	"<td><input type='text' value='"+list[i].NAME+"'/></td>"+
	        						"<td><input type='text' value='"+list[i].AGE+"'/></td>"+
	        						"<td><input type='text' value='"+list[i].PHONE_NUM+"'/></td>"+
	        						"<td><input type='email' value='"+list[i].EMAIL+"'/></td>"+	
	        						"<td><input type='text' value='"+list[i].ADDRESS+"'/></td>"+	
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
					"<td><input type='text'/></td>"+"<td><input type='email'/></td>"+
					"<td><input type='text'/></td>"+
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
    	    				console.log(param);
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
    		$("#seongjun").trigger("click");
	    });
	    
	    //$("#search").trigger("click");
	    
	} );
	
	function onSave(element){
		
		var userId = $(element).parent().parent().find("td:eq(1)").text();
		var userName = $(element).parent().parent().find("input:eq(1)").val();
		var age = $(element).parent().parent().find("input:eq(2)").val();
		var phoneNum= $(element).parent().parent().find("input:eq(3)").val();
		var email= $(element).parent().parent().find("input:eq(4)").val();
		var address = $(element).parent().parent().find("input:eq(5)").val();
		var url = "/update";
		
		if(userId == ""){
			userId = $(element).parent().parent().find("input:eq(0)").val();
			userName = $(element).parent().parent().find("input:eq(1)").val();
			age = $(element).parent().parent().find("input:eq(2)").val();
			phoneNum= $(element).parent().parent().find("input:eq(3)").val();
			email= $(element).parent().parent().find("input:eq(4)").val();
			address = $(element).parent().parent().find("input:eq(5)").val();
			url = "/create";
		}
		
		var param = {"USER_ID":userId, "USER_NAME":userName, "AGE":age, "PHONE_NUM":phoneNum, "EMAIL":email, "ADDRESS":address}
		console.log(param);
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
    			$("#seongjun").trigger("click");
    		}
    	});
    }
	</script>
</body>
</html>