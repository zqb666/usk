<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../taglib_includes.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String basePathFront = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/WsFrontSys" + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<title>采购管理列表--已出库</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../../common/common.jsp"%>
<script type="text/javascript">
   function rowformater(value,row,index)
{
//alert(row.pdfpath);
if(row.pdfpath==''||(typeof(row.pdfpath) == "undefined")){
return "未签订";
}else{
return "<a href='<%=basePath%>"+row.pdfpath+"' target='_blank'>查看</a>";
}

}

   function blpdfrowformater(value,row,index)
{
//alert(row.pdfpath);
if(row.blpdfpath==''||(typeof(row.blpdfpath) == "undefined")){
return "未打印";
}else{
return "<a href='<%=basePath%>"+row.blpdfpath+"' target='_blank'>查看</a>";
}

}
   function owpdfpathformater(value,row,index)
{
//alert(row.pdfpath);
if(row.owpdfpath==''||(typeof(row.owpdfpath) == "undefined")){
return "未打印";
}else{
return "<a href='<%=basePath%>"+row.owpdfpath+"' target='_blank'>查看</a>";
}

}


   function confirmpayment(value,row,index)
{
//alert(row.status);
var value=row.status;
//if(row.status==3){
//return "<a href='#' >确认付款</a>";
//}else{
//return "";
//}
//alert();
 if(value=='1'){
                        return '已过期';
                    }else if(value=='0'){
                        return '交易成功';
                    }else if(value=='2'){
                        return '待付款';
                    }else if(value=='3'){
                    
                  return  "<a  href='javascript:void(0);' onclick=\"tradingdo('tradingsuc.do',"+row.id+");\">确认到款</a>";
                      // return "<a href='javascript:void(0);' onclick=\"tradingdo("+"tradingsuc.do"+","+row.id+")\">确认付款</a>";
                    }else{
                    	return '未付款';
                    }
}

function tradingdo(url,param){
//alert(1);
 $.messager.confirm('提示信息','确定到款？',function(b){
   if(b){
   		dk(url,param);	
    }
  });
//$('#dlg').dialog('open');

    
}


function dk(url,param){

$.ajax({url: url, 
type: 'POST', 
data:{orderid:param}, 
dataType: 'json', 
timeout: 15000, 
error: function(){alert('Error ');}, 
success: function(result){
$.messager.alert('信息提示',result.resultMsg,'info');
$('#tt').datagrid('reload');
} 
});
}



    </script>
</head>

<body style="visibility: visible;">

	<div id="tb" style="padding:5px;height:auto">
		<div style="margin-bottom:5px">
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-add" plain="true" id="printDeliverbtn">打印出库单</a> -->
			<!--  
         
        &nbsp; &nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" id="editbtn">修改</a>  
        &nbsp; &nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="delbtn">删除</a>
          &nbsp; &nbsp;
       -->
			<!--  -->

		</div>
		<form:form action="" method="post" id="searchForm">
  订单号:   
      <!--    <input class="easyui-combobox" style="width:300px;" name="vmid"
				id="vmid"
				data-options="
					url:'viewPzJson.do',
					method:'get',
					valueField:'id',
					textField:'text',
					panelHeight:'auto'
			">-->
			订单号:<input class="easyui-validatebox" type="text" id="ordernum" name="ordernum" data-options="">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				id="submit_search" iconCls="icon-search"">Search</a> 
        
       &nbsp;    分页位置调整
        <select onchange="changeP(this.value)">
				<option>bottom</option>
				<option>top</option>
				<option>both</option>
			</select>
		</form:form>
	</div>


	<table id="tt" class="easyui-datagrid" style="width:auto;height:320px"
		data-options="fit:true,collapsible:true,rownumbers:true,url:'hascklist.do',fitColumns:false,singleSelect:false,sortOrder:'desc',sortName:'vmname',pagination:true,toolbar:'#tb'"
		title="采购管理">
		<thead>
			<tr>
				<th data-options="field:'purid',checkbox:true"></th>
				<th data-options="field:'id'">编号</th>
<th data-options="field:'ordernum'">订单编号</th>
				<th data-options="field:'vmname'">名称</th>
				<th data-options="field:'goodsnum'">货号</th>
				<th data-options="field:'weight'">重量(吨)</th>
				<th data-options="field:'addedprice'">价格</th>
				<th data-options="field:'omname'">产地</th>
				<th data-options="field:'ordertime'">下单时间</th>
				<th data-options="field:'buyaccout'">客户帐号</th>
				<th
					data-options="field:'pdfpath',formatter:  rowformater">采购合同预览</th>
<!--  <th
					data-options="field:'blpdfpath',formatter:  blpdfrowformater">提单预览</th>
					
				<th data-options="field:'blstatus',formatter:function(value){
                    if(value=='0'){
                        return '未打印';
                    }else if(value=='1'){
                        return '已打印';
                    }else{
                    	return '未打印';
                    }
                }">提单状态</th>-->
<th data-options="field:'owpdfpath',formatter:  owpdfpathformater">出库单预览</th>
			</tr>
		</thead>
	</table>

	<div id="dlg" class="easyui-dialog" title="采购合同信息确认" data-options=""
		style="width:500px;height:450px;padding:10px">
		<iframe src="" id="cgiframe" width='100%' height='100%' scrolling='no'></iframe>
	</div>


	<script type="text/javascript">
    
    function show(i)
{
var rows=$('#tt').datagrid('getRows');
console.logo(rows[i]);
}
    
    function addPanel(url,title){
	    var tab=parent.$('#tabs').tabs('exists',title);
			if(tab){
				//若存在，则直接打开
				parent.$('#tabs').tabs('select',title);
			}else{
				 parent.$('#tabs').tabs('add',{
	                title: title,
	                content: "<iframe width='100%' height='100%'  id='iframe' frameborder='0' scrolling='auto'  src='"+url+"'></iframe>",
	                closable: true
	            });
				
			}
           
       }
       
       //title 标题_编号
      function editPanel(url,title){
	     parent.$('#tabs').tabs('add',{
	                title: title,
	                content: "<iframe width='100%' height='100%'  id='iframe' frameborder='0' scrolling='auto'  src='"+url+"'></iframe>",
	                closable: true
	            });
           
       }
       
       
        //post提交批量删除信息并弹出处理结果
 function delDatas(delList,listId,address){
  $.messager.confirm('提示信息','确定要删除选中行吗？',function(b){
   if(b){

   
    $.ajax({url: address, 
type: 'POST', 
data:{ids:delList}, 
dataType: 'json', 
timeout: 15000, 
error: function(){alert('Error ');}, 
success: function(result){
$.messager.alert('信息提示',result.resultMsg,'info');
$(listId).datagrid('reload');
} 
});

   
   
   }
  });
 }
 
  function okDatas(delList,listId,address){
  $.messager.confirm('提示信息','确定要确认选中行吗？',function(b){
   if(b){
    $.ajax({url: address, 
type: 'POST', 
data:{ids:delList}, 
dataType: 'json', 
timeout: 15000, 
error: function(){alert('Error ');}, 
success: function(result){
$.messager.alert('信息提示',result.resultMsg,'info');
$(listId).datagrid('reload');
} 
});
   }
  });
 }
 
    var toolbar = [{
			text:'新增',
			iconCls:'icon-add',
			handler:function(){

}
		},{
			text:'修改',
			iconCls:'icon-edit',
			handler:function(){
			
			}
		},'-',{
			text:'删除',
			iconCls:'icon-remove',
			handler:function(){
			
		
			
			
			}
		}];
		
        function changeP(pos){
            $('#tt').datagrid('loadData',[]);
            $('#tt').datagrid({pagePosition:pos});
        }
        $(function (){
        
       	$('#dlg').dialog('close');
        
        	 $("#submit_search").click(function () {
        	 var f=$('#searchForm').form('validate');
        	 //alert($('#vmid').combobox('getValue'));
        	 //"vmid": $('#vmid').combobox('getValue')
        	 if(f){
        	 $('#tt').datagrid('load', { "ordernum": $('#ordernum').val()});
        	 }else{
        	 
        	 return f;
        	 }
         		
                
            });
        
        	//$('#tt').datagrid('reload',{pageindex:11});
        	 $("#addbtn").click(function () {
        			addPanel('addGoods.do','新增仓库');
        	 }); 
        	 
        	  $("#editbtn").click(function () {
        			var rows = $("#tt").datagrid("getSelections");    // 获取所有选中的行
			 var parks = [];
            if(rows == 0){
                $.messager.alert("系统提示","请选择要修改的数据!","info");
                return;
            }else if(rows.length >1){
              $.messager.alert("系统提示","一次只能修改一条数据!","info");
                return;
            
            }else{
                  for(var i=0;i<rows.length;i++){
                      parks.push(rows[i].id);
                  }
                  var parkparams = parks.join(',');
                
       editPanel('eidtGoods.do?id='+parkparams,'修改货物信息_'+parkparams);
			
			}
        	 });
        	 
        	  $("#addhtbtn").click(function () {
        						var rows = $("#tt").datagrid("getSelections");    // 获取所有选中的行
	   var parks = [];
            if(rows == 0){
                $.messager.alert("系统提示","请选择要签订合同的订单!","info");
                return;
		}else if(rows.length >1){
			$.messager.alert("系统提示","一次只能签订一条合同!","info");
            }else{
                  for(var i=0;i<rows.length;i++){
                      parks.push(rows[i].id);
                  }
                 
    
                  var parkparams = parks.join(',');
					//delDatas(parkparams,'#tt','deleteGoods.do');
					 document.getElementById("cgiframe").src='purchasingManagement.do?orderid='+parkparams;
					$('#dlg').dialog('open');
					
					
			}
        	 });
        	
        	
        	  $("#editbtn").click(function () {
        			var rows = $("#tt").datagrid("getSelections");    // 获取所有选中的行
			 var parks = [];
            if(rows == 0){
                $.messager.alert("系统提示","请选择要修改的数据!","info");
                return;
            }else if(rows.length >1){
              $.messager.alert("系统提示","一次只能修改一条数据!","info");
                return;
            
            }else{
                  for(var i=0;i<rows.length;i++){
                      parks.push(rows[i].id);
                  }
                  var parkparams = parks.join(',');
                
       editPanel('eidtGoods.do?id='+parkparams,'修改货物信息_'+parkparams);
			
			}
        	 });
        	
        	
        		  $("#addqrbtn").click(function () {
        						var rows = $("#tt").datagrid("getSelections");    // 获取所有选中的行
	   var parks = [];
            if(rows == 0){
                $.messager.alert("系统提示","请选择要操作的数据!","info");
                return;

            }else{
                  for(var i=0;i<rows.length;i++){
                      parks.push(rows[i].purid);
                  }
                  var parkparams = parks.join(',');
					okDatas(parkparams,'#tt','confirmPmOK.do');
			}
        	 });
        	 
        	 
        	 
        	  $("#printDeliverbtn").click(function () {
        			var rows = $("#tt").datagrid("getSelections");    // 获取所有选中的行
			 var parks = [];
            if(rows == 0){
                $.messager.alert("系统提示","请选择要打印的数据!","info");
                return;
            }else if(rows.length >1){
              $.messager.alert("系统提示","一次只能打印一条数据!","info");
                return;
            
            }else{
                  for(var i=0;i<rows.length;i++){
                      parks.push(rows[i].id);
                  }
                  var parkparams = parks.join(',');
                
       editPanel('printDeliver.do?orderid='+parkparams,'打印出库单'+parkparams);
			
			}
        	 });
        	
        });
    </script>


</body>
</html>
